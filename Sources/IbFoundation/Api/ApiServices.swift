//
//  ApiServices.swift
//  IbToolKit
//
//  Created by Ibrahim fuseini on 09/12/2025.
//

import Foundation

public final class ApiServices: ApiServiceProtocol {
    private let urlSession: URLSession
    private let decoder: JSONDecoder

    public init(urlSession: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }

    public func fetchData<T>(for endpoint: any URLBuilding) async throws -> T where T : Decodable {
        
        guard let urlRequest = endpoint.build else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let dataResponse: T = try decoder.decode(T.self, from: data)
            return dataResponse
        } catch {
            throw error
        }
    }
}
