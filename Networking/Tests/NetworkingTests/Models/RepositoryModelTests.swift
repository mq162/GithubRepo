//
//  RepositoryModelTests.swift
//  
//
//  Created by Braly Admin on 28/11/2023.
//

import XCTest
@testable import Networking

final class RepositoryModelTests: XCTestCase {

    func testModelDataIsValid() throws {
        guard let path = Bundle.module.path(forResource: "Repository", ofType: "json", inDirectory: "assets"),
        let jsonData = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }

        let modelJson = try JSONDecoder.apiDecoder.decode(Repository.self, from: jsonData)
        let modelInit = Repository(id: 3, name: "GBCli", description: "Prepare sprites and tileset graphics for creating games on the spectrum next")

        XCTAssertEqual(modelJson.id, modelInit.id)

        XCTAssertEqual(modelJson.name, modelInit.name)
        XCTAssertEqual(modelJson.description, modelInit.description)
    }

    func testModelDataIsInValid() throws {
        let jsonData = "{someData:[something:123]}".data(using: .utf8)!

        XCTAssertThrowsError(try JSONDecoder.apiDecoder.decode(Repository.self, from: jsonData))
    }

}
