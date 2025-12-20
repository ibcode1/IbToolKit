//
//  File.swift
//  IbToolKit
//
//  Created by Ibrahim fuseini on 20/12/2025.
//


import Foundation

public extension Bundle {

  func decode<D: Decodable>(
    _ type: D.Type = D.self,
    from file: String,
    dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
    keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
    jsonDecoder: JSONDecoder = JSONDecoder()
  ) -> D {

    // 1. Safely find and locate our file to decode
    guard let url = self.url(forResource: file, withExtension: nil) else {
      fatalError("Failed to locate \(file) in bundle.") // The file cannot be located in your project.
    }

    // 2. Extract the data from the file
    guard let data = try? Data(contentsOf: url) else {
      fatalError("Failed to data from \(file) in bundle.")
    }

    // 3. Attempt to decode our data from the file
    do {
      let response: D = try jsonDecoder.decode(D.self, from: data)
      return response

      // 5. Catch any errors and through fatal errors
    } catch DecodingError.keyNotFound(let key, let context) {
      fatalError("Failed to decode \("") from bundle due to missing key '\(key.stringValue)' not found - \(context.debugDescription)")

    } catch DecodingError.typeMismatch(_, let context) {
      fatalError("Failed to decode \("") from bundle due to type mismatch - \(context.debugDescription)")
    } catch {
      fatalError("")
    }
  }
}
