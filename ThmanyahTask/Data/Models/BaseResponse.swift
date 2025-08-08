//
//  BaseModel.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import Foundation

struct BaseResponse: Codable {
    let sections : [ModelSection]?
    let pagination : Pagination?
    
}

struct Pagination : Codable {
    let nextPage : String?
    let totalPages : Int?
}
