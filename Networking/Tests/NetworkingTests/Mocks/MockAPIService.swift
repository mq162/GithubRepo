//
//  File.swift
//  
//
//  Created by Braly Admin on 28/11/2023.
//

import Foundation
import Networking

final class MockAPIService: APIServiceProtocol {

    var sendRequestIsCalled = false

    func send<T, V>(request: T) async -> Result<V, APIError> where T: BaseAPIProtocol, V: Decodable {
        sendRequestIsCalled = true
        return .failure(.unknown(nil))
    }
}
