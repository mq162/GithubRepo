//
//  RepositoryAPIServiceTest.swift
//  
//
//  Created by Braly Admin on 27/11/2023.
//

import XCTest
@testable import Networking

final class RepositoriesAPIServiceTest: XCTestCase {

    private let apiService = MockAPIService()
    private var repositoriesService: RepositoriesAPIServiceProtocol!

    override func setUpWithError() throws {
        repositoriesService = RepositoriesAPIService(apiService: apiService, apiConfig: MockAPIConfigProtocol.githubAPI)
    }

    override func tearDownWithError() throws {
        repositoriesService = nil
    }

    func testGetReposCalledSuccess() async throws {

        XCTAssertFalse(apiService.sendRequestIsCalled)
        _ = await repositoriesService?.getRepos(page: 1, perPage: 20, sort: .pushed,
                                                type: .owner, direction: .desc)
        XCTAssertTrue(apiService.sendRequestIsCalled)
    }

}
