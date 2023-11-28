//
//  File.swift
//  
//
//  Created by Quang on 27/11/2023.
//

import Foundation
import Networking
import Common

struct MockAPIProtocol: BaseAPIProtocol {
    
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
        return ["Authorization": "Bearer \(config.token)"]
    }

    init(config: APIConfigProtocol) {
        self.config = config
        requestModel = GetRepositoriesRequest(page: 1,
                                              perPage: 30,
                                              sort: .pushed,
                                              type: .owner,
                                              direction: .asc)
    }
}
