//
//  RestClient.swift
//  GihubRepo
//
//  Created by Braly Admin on 24/11/2023.
//

import Foundation
import Common

public protocol APIServiceProtocol {
    func send<T, V>(request: T) async -> Result<V, APIError> where T: BaseAPIProtocol, V: Decodable
}

public struct APIService: APIServiceProtocol {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func send<T, V>(request: T) async -> Result<V, APIError> where T: BaseAPIProtocol, V: Decodable {
        
        guard let urlRequest = try? request.asURLRequest() else {
            Logger.e(messages: "Send API request failed invalid url")
            return .failure(.invalidURL)
        }

        Logger.d(messages: String(format: "-------------------\n\n link: = %@ \n params: = %@ \n",
                                  (urlRequest.url?.absoluteString ?? ""), request.params))
        
        do {
            let (data, response) = try await session.data(for: urlRequest)

            // Handle the URLResponse returned from our async request
            guard let response = response as? HTTPURLResponse else {
                Logger.e(messages: "Send API request failed invalid response")
                return .failure(.invalidResponse)
            }
            
            Logger.d(messages: "Send API response status code: \(response.statusCode)")
            // Verify the HTTP status code.
            switch response.statusCode {
            case 200...299:
                if let decodedResponse = try? request.decoder.decode(V.self, from: data) {
                    Logger.d(messages: "Send API request success with response \(decodedResponse)")
                    return .success(decodedResponse)
                } else {
                    Logger.e(messages: "Send API request failed bad request")
                    return .failure(.decoding("Decoding response error"))
                }
            case 400...499:
                Logger.e(messages: "Send API request failed bad request")
                return .failure(.badRequest("Bad URL request error."))
            case 500...599:
                Logger.e(messages: "Send API request failed internal server error")
                return .failure(.server("There was a server error."))
            default:
                Logger.e(messages: "Send API request failed unknown error")
                return .failure(.unknown(nil))
            }
        } catch (let error) {
            Logger.e(messages: "Send API request failed error: \(error)")
            return .failure(.unknown("\(error.localizedDescription)"))
        }
    }

}
