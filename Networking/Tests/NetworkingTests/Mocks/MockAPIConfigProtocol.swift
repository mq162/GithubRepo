//
//  File.swift
//  
//
//  Created by Quang on 27/11/2023.
//

import Networking

enum MockAPIConfigProtocol: APIConfigProtocol {
    
    case githubAPI
    
    var token: String {
        "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"
    }
    
    var baseURL: String {
        "https://api.github.com"
    }
}
