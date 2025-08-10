//
//  API.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import Foundation

enum API {
    case getHomeScreenSections(pageNumber: Int = 1)
    /// I used the very same home sections API bacause the Search API is returning mock data, Doesn't have beautiful images to show the UI, Also doesn't contain section types to present implemented Section
    case performSearch(query: String)

    private
    var baseURL: URL {
        URL(string: "https://api-v2-b2sit6oh3a-uc.a.run.app/")!
    }
    
    var path: URL {
        switch self {
        case .getHomeScreenSections(let pageNumber):
            let queryItems: [URLQueryItem] = [
                URLQueryItem(name: "page", value: "\(pageNumber)")
            ]
            return baseURL.appendingPathComponent("home_sections").appending(queryItems: queryItems)
        case .performSearch(query: let query):
            let queryItems: [URLQueryItem] = [
                URLQueryItem(name: "search", value: query)
            ]
            return baseURL.appendingPathComponent("home_sections").appending(queryItems: queryItems)
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
}
