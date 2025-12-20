//
//  Decoder.swift
//  IbToolKit
//
//  Created by Ibrahim fuseini on 10/12/2025.
//

import Foundation
import SwiftData

// MARK: - JSONDecoder factory for SwiftData


public extension JSONDecoder {

    /// Creates a JSONDecoder pre-configured for use with SwiftData models.
    ///
    /// - Parameters:
    ///   - dateDecodingStrategy: How dates in JSON should be decoded (default: .deferredToDate)
    ///   - keyDecodingStrategy:  How keys in JSON should be mapped to Swift properties (default: .useDefaultKeys)
    ///   - modelContext:         The SwiftData ModelContext that will be used by model `init(from:)` methods
    ///                           to insert new objects. Pass `nil` if you don't need automatic insertion.
    ///
    /// - Returns: A configured JSONDecoder

    static func jsonDecoder(
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        modelContainer: ModelContainer? = nil
    ) -> JSONDecoder {

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        // SwiftData uses the "context" key (the same one the template uses)
        if let container = modelContainer {
            decoder.userInfo[CodingUserInfoKey.modelContainer] = container
        }

        return decoder
    }
}

// MARK: - Convenience CodingUserInfoKey for SwiftData

public extension CodingUserInfoKey {
    static let modelContainer = CodingUserInfoKey(rawValue: "modelContainer")!
}
