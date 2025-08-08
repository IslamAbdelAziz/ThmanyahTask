//
//  GenericType.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import Foundation

//MARK: Generic Resource
struct GenericResource<T: Codable> {
    var url: URL
    var method: HTTPMethod
    var modelType: T.Type
}

