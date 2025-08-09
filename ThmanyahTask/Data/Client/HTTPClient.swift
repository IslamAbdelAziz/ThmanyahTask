//
//  HTTPClient.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import Foundation

//MARK: Client
enum HTTPMethod {
    case get

    var name: String {
        switch self {
        case .get:
            return "GET"
        }
    }
}

struct HTTPClient {
    private
    let session: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "Content-Type": "application/json"
        ]
        self.session = URLSession(configuration: configuration)
    }
    
    func load<T: Decodable>(_ resource: GenericResource<T>) async throws -> T? {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.method.name
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200..<300).contains(response.statusCode) else {
            throw NetworkError.httpError(response.statusCode)
        }
        
        do {
            let decode = JSONDecoder()
            decode.keyDecodingStrategy = .convertFromSnakeCase
            return try decode.decode(resource.modelType.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
}
