//
//  ListRepositoryViewModelTests.swift
//  GihubRepoTests
//
//  Created by Braly Admin on 28/11/2023.
//

import XCTest
import Networking
import Factory
@testable import _DEV__Github_Repo

@MainActor
final class ListRepositoryViewModelTests: XCTestCase {

    private var viewModel: ListRepositoryViewModel!

    override func setUp() {
        Container.shared.repositoriesAPIService.register { MockRepositoriesAPIServiceSuccess() }
        viewModel = ListRepositoryViewModel()
    }

    override func tearDown() {
        viewModel = nil
    }

    func testGetRepositoriesSuccess() async throws {
        XCTAssertFalse(viewModel.isLoading, "The view model loading state should be false initally")

        defer {
            XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading any data")
        }

        await viewModel.getRepositories()

        XCTAssertEqual(viewModel.repositories.count, 6, "There should be 6 repos in our data array")
    }

    func testGetMoreRepositoriesSuccess() async throws {

        XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading any data")

        defer {
            XCTAssertFalse(viewModel.isFetching, "The view model shouldn't be fetching any data")
            XCTAssertEqual(viewModel.viewState, .finished, "The view model view state should be finished")
        }

        await viewModel.getRepositories()

        XCTAssertEqual(viewModel.repositories.count, 6, "The should be 6 repos within our data array")

        await viewModel.loadMoreRepositories()

        XCTAssertEqual(viewModel.repositories.count, 12, "The should be 12 repos within our data array")

        XCTAssertEqual(viewModel.nextPage, 3, "The next page should be 3")
    }

    func testShouldLoadMoreReturnsTrue() async throws {
        await viewModel.getRepositories()

        let repos = try! JSONFileMapper.decode(file: "Repositories", type: [Repository].self)

        let hasReachedEnd = viewModel.shouldLoadMore(repo: repos[repos.count - 2])

        XCTAssertTrue(hasReachedEnd, "The last repo should match")
    }
}
