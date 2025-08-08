//
//  API.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import Foundation

enum API {
    case getHomeScreenSections(pageNumber: Int = 1)
    
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
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
}
