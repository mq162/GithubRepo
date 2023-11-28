//
//  APIConfigProtocol.swift
//  
//
//  Created by Quang on 26/11/2023.
//

import Foundation

public protocol APIConfigProtocol {
    var token: String { get }
    var baseURL: String { get }
}
