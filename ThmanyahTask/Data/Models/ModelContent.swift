//
//  ModelContent.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import Foundation

struct ModelContent : Codable {
    let podcastId : String?
    let name : String?
    let description : String?
    let avatarUrl : String?
    let episodeCount : Int?
    let duration : Int?
    let language : String?
    let priority : Int?
    let popularityScore : Int?
    let score : Double?
    
}
