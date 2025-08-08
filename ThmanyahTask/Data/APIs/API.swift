//
//  API.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import Foundation

enum API {
    case getHomeScreenSections
    
    private
    var baseURL: URL {
        URL(string: "https://api-v2-b2sit6oh3a-uc.a.run.app/")!
    }
    
    var path: URL {
        switch self {
        case .getHomeScreenSections:
            return baseURL.appendingPathComponent("home_sections")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
}
