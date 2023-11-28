//
//  ListRepositoryViewModel.swift
//  GihubRepo
//
//  Created by Quang on 26/11/2023.
//

import Foundation
import Networking
import Common
import Factory

@MainActor
final class ListRepositoryViewModel: ObservableObject {
    
    @Injected(\.repositoriesAPIService) private var service
    
    @Published private(set) var repositories = [Repository]()
    @Published private(set) var error: APIError?
    @Published private(set) var viewState: ViewState?
    @Published var showError = false
        
    private(set) var nextPage = 1
    private let perPage = 20
    private var shouldLoadNextPage = true

    var isLoading: Bool {
        viewState == .loading
    }

    var isFetching: Bool {
        viewState == .fetching
    }
    
    func getRepositories() async {
        Logger.d(messages: "Getting repositories...")

        viewState = .loading

        defer {
            viewState = .finished
        }
        
        let reposResult = await service.getRepos(page: nextPage,
                                                 perPage: perPage,
                                                 sort: .pushed,
                                                 type: .owner,
                                                 direction: .desc)
        switch reposResult {
        case .success(let repositories):
            self.repositories = repositories
            shouldLoadNextPage = !repositories.isEmpty
            self.nextPage += 1
        case .failure(let error):
            self.error = error
            showError = true
            Logger.e(messages: "Get repositories failed with error: \(error)")
        }
    }
    
    func loadMoreRepositories() async {
        if shouldLoadNextPage && !isFetching {
            viewState = .fetching

            defer {
                viewState = .finished
            }

            Logger.d(messages: "Fetching more repositories with page \(nextPage) ...")

            let reposResult = await service.getRepos(page: nextPage,
                                                     perPage: perPage,
                                                     sort: .pushed,
                                                     type: .owner,
                                                     direction: .desc)
            switch reposResult {
            case .success(let repositories):
                self.repositories += repositories
                shouldLoadNextPage = !repositories.isEmpty
                self.nextPage += 1
            case .failure(let error):
                self.error = error
                showError = true
                Logger.e(messages: "Load more repositories failed with error: \(error)")
            }
        }
    }

    func shouldLoadMore(repo: Repository) -> Bool {
        repositories[repositories.count - 2].id == repo.id
    }
}

extension ListRepositoryViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}
