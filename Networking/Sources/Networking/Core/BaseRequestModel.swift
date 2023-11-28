//
//  File.swift
//  
//
//  Created by Quang on 26/11/2023.
//

import Common
import Foundation

public protocol BaseRequestModel: Encodable {

}

extension BaseRequestModel {
    
    public func toJSON(encoder: JSONEncoder = .apiEncoder) -> [String: Any] {
        guard let dictionary = try? JSONSerialization.jsonObject(
            with: encoder.encode(self), options: .allowFragments
        ) as? [String: Any] else {
            return [:]
        }

        return dictionary.mapValues { $0 }
    }
}
