//
//  Container+Injection.swift
//  GihubRepo
//
//  Created by Quang on 26/11/2023.
//

import Networking
import Factory

@MainActor
extension Container {
    
    var apiService: Factory<APIServiceProtocol> {
        self { APIService() }
    }
    
    var repositoriesAPIService: Factory<RepositoriesAPIServiceProtocol> {
        self { RepositoriesAPIService(apiService: self.apiService.callAsFunction(),
                                      apiConfig: ConfigurationProvider.githubAPI) }
    }
    
}
