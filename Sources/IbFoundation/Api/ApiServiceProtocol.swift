//
//  ApiServiceProtocol.swift
//  IbToolKit
//
//  Created by Ibrahim fuseini on 09/12/2025.
//

import Foundation

protocol ApiServiceProtocol {

    func fetchData<T: Decodable>(for endpoint: URLBuilding) async throws -> T
}
