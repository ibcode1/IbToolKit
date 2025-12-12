//
//  URLBuild.swift
//  IbToolKit
//
//  Created by Ibrahim fuseini on 09/12/2025.
//

import Foundation

public protocol URLBuilding {
    /// A fully constructed URLRequest based on the current state of the builder.
    ///
    /// Implementations should return `nil` if the components cannot form a valid URL.
    /// Accessing this property should be side-effect free.
    var build: URLRequest? { get }

    /// The base path component to prepend to endpoint paths (for example, `/v1`).
    ///
    /// Conformers can use this to provide a common prefix that is joined with `path`.
    /// The default implementation returns an empty string.
    var basePath: String { get }

    /// Creates a new URL builder with the given URL components.
    ///
    /// - Parameters:
    ///   - scheme: The URL scheme (for example, `https`).
    ///   - host: The hostname (for example, `api.example.com`).
    ///   - path: The endpoint path (for example, `/users`). Conformers may combine this with `basePath`.
    init(scheme: String, host: String, path: String)

    /// Returns a new builder by adding a query item to the request URL.
    ///
    /// Conformers should treat builders as value-like and return a modified instance when possible.
    /// If the query item cannot be added (for example, due to invalid characters that cannot be percent-encoded),
    /// return `nil`.
    ///
    /// - Parameters:
    ///   - name: The query item name.
    ///   - value: The query item value. If `nil`, the query may be appended as a flag (e.g., `?name`).
    /// - Returns: A new builder with the query item applied, or `nil` if the operation fails.
    func addQueryItem(name: String, value: String?) -> Self?

    /// Returns a new builder by adding or replacing an HTTP header field on the request.
    ///
    /// Conformers should return a modified instance and avoid side effects on the receiver if possible.
    ///
    /// - Parameters:
    ///   - field: The HTTP header field name (for example, `Content-Type`).
    ///   - value: The value for the header field.
    /// - Returns: A new builder with the header applied.
    func addHeader(field: String, value: String) -> Self
}

public extension URLBuilding {
    /// The default base path is an empty string.
    var basePath: String { "" }

    /// Convenience initializer that defaults the scheme to `https`.
    ///
    /// - Parameters:
    ///   - scheme: The URL scheme. Defaults to `https`.
    ///   - host: The hostname (for example, `api.example.com`).
    ///   - path: The endpoint path (for example, `/users`).
    init(scheme: String = "https", host: String, path: String) {
        self.init(scheme: scheme, host: host, path: path)
    }

    /// Default no-op implementation that returns `self`.
    ///
    /// Conforming types should override this to return a modified builder or `nil`
    /// if the item cannot be applied.
    func addQueryItem(name: String, value: String?) -> Self? {
        self
    }

    /// Default no-op implementation that returns `self`.
    ///
    /// Conforming types should override this to return a modified builder.
    func addHeader(field: String, value: String) -> Self {
        self
    }
}
