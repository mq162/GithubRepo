//
//  APIServiceTest.swift
//  
//
//  Created by Braly Admin on 27/11/2023.
//

import XCTest
@testable import Networking

final class APIServiceTest: XCTestCase {

    private var url: URL!
    private var session: URLSession!
    private var service: APIService!

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
        url = URL(string: MockAPIConfigProtocol.githubAPI.baseURL)!
        service = APIService(session: session)
    }

    override func tearDownWithError() throws {
        url = nil
        session = nil
        service = nil
    }

    func testAPIServiceResponseSuccess() async throws {
        guard let path = Bundle.module.path(forResource: "Repositories", ofType: "json", inDirectory: "assets"),
        let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, data)
        }
        
        let res: Result<[Repository], APIError> = await service.send(request: MockAPIProtocol(config: MockAPIConfigProtocol.githubAPI))
        
        let repos = try res.get()
        
        let staticJSON = try JSONDecoder.apiDecoder.decode([Repository].self, from: data)
        
        XCTAssertEqual(repos, staticJSON, "The returned response should be decoded properly")
    }

    func testAPIServiceResponseDecodingError() async throws {
        let jsonData = "{someData:[something:123]}".data(using: .utf8)!

        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, jsonData)
        }

        let res: Result<[Repository], APIError> = await service.send(request: MockAPIProtocol(config: MockAPIConfigProtocol.githubAPI))

        do  {
            _ = try res.get()
        } catch {
            guard let networkingError = error as? APIError else {
                XCTFail("Got the wrong type of error, expecting APIError")
                return
            }
            XCTAssertEqual(networkingError, APIError.decoding("Decoding response error"), "Error should be APIError decoding")
        }
    }

    func testAPIServiceResponseBadRequestError() async {
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url, statusCode: 400, httpVersion: nil, headerFields: nil)
            return (response!, nil)
        }

        let res: Result<[Repository], APIError> = await service.send(request: MockAPIProtocol(config: MockAPIConfigProtocol.githubAPI))

        do  {
            _ = try res.get()
        } catch {
            guard let networkingError = error as? APIError else {
                XCTFail("Got the wrong type of error, expecting APIError")
                return
            }
            XCTAssertEqual(networkingError, APIError.badRequest("Bad URL request error."), "Error should be APIError badRequest")
        }
    }

    func testAPIServiceResponseServerError() async {
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url, statusCode: 500, httpVersion: nil, headerFields: nil)
            return (response!, nil)
        }

        let res: Result<[Repository], APIError> = await service.send(request: MockAPIProtocol(config: MockAPIConfigProtocol.githubAPI))

        do  {
            _ = try res.get()
        } catch {
            guard let networkingError = error as? APIError else {
                XCTFail("Got the wrong type of error, expecting APIError")
                return
            }
            XCTAssertEqual(networkingError, APIError.server("There was a server error."), "Error should be APIError server")
        }
    }

    func testAPIServiceResponseUnknownStatusCode() async {
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url, statusCode: 300, httpVersion: nil, headerFields: nil)
            return (response!, nil)
        }

        let res: Result<[Repository], APIError> = await service.send(request: MockAPIProtocol(config: MockAPIConfigProtocol.githubAPI))

        do  {
            _ = try res.get()
        } catch {
            guard let networkingError = error as? APIError else {
                XCTFail("Got the wrong type of error, expecting APIError")
                return
            }
            XCTAssertEqual(networkingError, APIError.unknown(nil), "Error should be APIError unknown")
        }
    }

}
