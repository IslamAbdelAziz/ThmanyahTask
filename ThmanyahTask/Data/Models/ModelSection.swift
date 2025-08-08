//
//  ModelSection.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import Foundation

struct ModelSection : Codable {
    let name : String?
    let type : String?
    let contentType : String?
    let order : Int?
    let content : [ModelContent]?
}
