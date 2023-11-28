//
//  BaseAPIProtocol.swift
//  GihubRepo
//
//  Created by Braly Admin on 24/11/2023.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

public protocol BaseAPIProtocol: URLRequestConvertible {
    associatedtype RequestModel
    associatedtype Config

    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var params: Parameters { get }
    var defaultHeaders: [String: String] { get }
    var headers: [String: String] { get }
    var decoder: JSONDecoder { get }
    var requestModel: RequestModel { get set }
    var config: APIConfigProtocol { get set }
}

extension BaseAPIProtocol {
    
    public var host: String {
        return ""
    }

    public var method: HTTPMethod {
        return .get
    }

    public var params: Parameters {
        return [:]
    }
    
    public var defaultHeaders: [String : String] {
        return [:]
    }

    public var headers: [String : String] {
        return defaultHeaders
    }
    
    public var decoder: JSONDecoder {
        return JSONDecoder.apiDecoder
    }

    public func asURLRequest() throws -> URLRequest {
        let baseURL = URL(string: host)!
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        components?.queryItems = params.map { .init(name: $0.key, value: "\($0.value)") }

        guard let url = components?.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        return request
    }
}
