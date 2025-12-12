//
//  URLBuilder.swift
//  IbToolKit
//
//  Created by Ibrahim fuseini on 09/12/2025.
//

import Foundation

public final class URLBuilder: URLBuilding {

    // Internal URL components used to assemble the URL.
    private var urlComponents: URLComponents

    // Accumulated query items that will be applied to `urlComponents`.
    private var queryItems: [URLQueryItem]?

    // Accumulated HTTP headers to apply to the URLRequest. Keys are field names (e.g., "Accept").
    private var headers: [String: String]?

    /// A fully constructed URLRequest based on the current state of the builder.
    ///
    /// Returns `nil` if the URL cannot be formed from the current components.
    /// This property is side-effect free.
    public var build: URLRequest? {
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        headers?.forEach { field, value in
            request.addValue(value, forHTTPHeaderField: field)
        }
        return request
    }

    /// Creates a new URL builder with the given URL components.
    ///
    /// - Parameters:
    ///   - scheme: The URL scheme (for example, `https`). Defaults to `https`.
    ///   - host: The hostname (for example, `api.example.com`).
    ///   - basePath: A common base path to be prepended to `path` (for example, `/v1`). Defaults to empty.
    ///   - path: The endpoint path (for example, `/users`).
    ///
    /// The initializer normalizes `basePath` and `path` to avoid duplicate or missing slashes.
    public required init(scheme: String = "https", host: String,
                         basePath: String = "", path: String) {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = URLBuilder.normalizePath(basePath, path)
        self.urlComponents = components
    }

    /// Returns a new builder with the given query item appended to the URL.
    ///
    /// If `value` is `nil`, the query item is encoded as a flag (e.g., `?name`)
    /// using `URLQueryItem(name:value:)` with a nil value.
    ///
    /// - Parameters:
    ///   - name: The query item name.
    ///   - value: The query item value, or `nil` to encode as a flag.
    /// - Returns: The same builder instance for fluent chaining, or `nil` if the operation fails.
    @discardableResult
    public func addQueryItem(name: String, value: String?) -> Self? {
        if queryItems == nil {
            queryItems = []
        }
        queryItems?.append(URLQueryItem(name: name, value: value))
        urlComponents.queryItems = queryItems
        return self
    }

    /// Returns a new builder with the given HTTP header applied.
    ///
    /// If the header already exists, its value is replaced.
    ///
    /// - Parameters:
    ///   - field: The HTTP header field name (for example, `Accept`).
    ///   - value: The header value (for example, `application/json`).
    /// - Returns: The same builder instance for fluent chaining.
    @discardableResult
    public func addHeader(field: String, value: String) -> Self {
        if headers == nil {
            headers = [:]
        }
        headers?[field] = value
        return self
    }

    // MARK: - Helpers

    /// Joins `basePath` and `path` with proper slash normalization.
    ///
    /// Examples:
    /// - ("", "users") -> "/users"
    /// - ("/v1", "users") -> "/v1/users"
    /// - ("/v1/", "/users") -> "/v1/users"
    private static func normalizePath(_ basePath: String, _ path: String) -> String {
        func trim(_ s: String) -> String {
            s.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        }
        let b = trim(basePath)
        let p = trim(path)
        switch (b.isEmpty, p.isEmpty) {
        case (true, true): return "/"
        case (true, false): return "/" + p
        case (false, true): return "/" + b
        case (false, false): return "/" + b + "/" + p
        }
    }
}
