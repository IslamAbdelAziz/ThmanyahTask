//
//  ModelSection.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import Foundation

enum UIType: String, Codable {
    case square
    case twoLinesGrid = "2_lines_grid"
    case bigSquare = "big_square"
    case queue
    case bigSpaceSquare = "big square"
}

struct ModelSection : Codable, Identifiable {
    let id = UUID()
    let name : String?
    let type : UIType?
    let contentType : String?
    let order : Int?
    let content : [ModelContent]?
}
