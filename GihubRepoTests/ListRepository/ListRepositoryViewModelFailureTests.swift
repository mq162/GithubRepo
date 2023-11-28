//
//  ListRepositoryViewModelFailure.swift
//  GihubRepoTests
//
//  Created by Braly Admin on 28/11/2023.
//

import XCTest
import Networking
import Factory
@testable import _DEV__Github_Repo

@MainActor
final class ListRepositoryViewModelFailureTests: XCTestCase {

    private var viewModel: ListRepositoryViewModel!

    override func setUp() {
        Container.shared.repositoriesAPIService.register { MockRepositoriesAPIServiceFailure() }
        viewModel = ListRepositoryViewModel()
    }

    override func tearDown() {
        viewModel = nil
    }

    func testGetRepositoriesFail() async {

        XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading any data")

        defer {
            XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading any data")
        }

        await viewModel.getRepositories()

        XCTAssertTrue(viewModel.showError, "The view model should have an error")
        XCTAssertNotNil(viewModel.error, "The view model error should be set")

    }

    func testLoadMoreRepositoriesFail() async {

        XCTAssertFalse(viewModel.isFetching, "The view model shouldn't be fetching any data")

        defer {
            XCTAssertFalse(viewModel.isFetching, "The view model shouldn't be fetching any data")
        }

        await viewModel.loadMoreRepositories()

        XCTAssertTrue(viewModel.showError, "The view model should have an error")
        XCTAssertNotNil(viewModel.error, "The view model error should be set")

    }

}
