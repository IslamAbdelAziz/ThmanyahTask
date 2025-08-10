//
//  HTTPClientTest.swift
//  ThmanyahTaskTests
//
//  Created by iSlam AbdelAziz on 10/08/2025.
//

import Testing
import Foundation

@testable import ThmanyahTask

struct TestHTTPClient {
    let client = HTTPClient()
    
    
    @Test func testBadURL() async throws {
        let wrongURL = URL(string: "https://api-v2-b2sit6oh3a-uc.a.run.app/123123")!
        let resource = GenericResource(url: wrongURL, method: .get, modelType: [ModelSection].self)
        
        do {
            let _ = try await client.load(resource)
        } catch {
            print(error)
            #expect(type(of: error)  == type(of: NetworkError.httpError(404)))
        }
    }
    
    @Test func testWrongHTTPMethod() async throws {
        var url = URL(string: "https://api-v2-b2sit6oh3a-uc.a.run.app/")!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(1)")
        ]
        url = url.appendingPathComponent("home_sections").appending(queryItems: queryItems)

        let resource = GenericResource(url: url, method: .delete, modelType: [ModelSection].self)
        
        do {
            let _ = try await client.load(resource)
        } catch {
            print(error)
            #expect(type(of: error)  == type(of: NetworkError.httpError(404)))
        }
    }
}
