//
//  ReposiroriesAPI.swift
//  GihubRepo
//
//  Created by Braly Admin on 25/11/2023.
//

import Foundation

struct GetRepositoriesAPI: BaseAPIProtocol {
    typealias Config = APIConfigProtocol
    typealias RequestModel = GetRepositoriesRequest
    
    var config: APIConfigProtocol
    
    var requestModel: GetRepositoriesRequest
    
    var host: String {
        return config.baseURL
    }

    var path: String {
        return "/users/apple/repos"
    }

    var params: Parameters {
        return requestModel.toJSON()
    }
    
    var headers: [String : String] {
        var header = defaultHeaders
        header["accept"] = "application/vnd.github+json"
        
        // add auth token if needed
        //header["Authorization"] = "Bearer \(config.token)"
        return header
    }

    init(page: Int, perPage: Int, sort: Sort,
         type: SearchType, direction: OrderType,
         config: APIConfigProtocol) {
        self.config = config
        requestModel = GetRepositoriesRequest(
            page: page,
            perPage: perPage,
            sort: sort,
            type: type,
            direction: direction)
    }
}
