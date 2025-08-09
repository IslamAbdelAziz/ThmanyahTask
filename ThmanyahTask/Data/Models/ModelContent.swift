//
//  ModelContent.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import Foundation

struct ModelContent : Codable, Identifiable {
    let id = UUID()
    let podcastId : String?
    let name : String?
    let description : String?
    let avatarUrl : String?
    let episodeCount : Int?
    var duration : Int? 
    var durationText : String?
    let language : String?
    let priority : Int?
    let popularityScore : Int?
    let score : Double?
    
    private
    func splitDurationIntoHoursAndMinutes(from seconds: Int) -> (hours: Int, minutes: Int) {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        return (hours, minutes)
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.podcastId = try container.decodeIfPresent(String.self, forKey: .podcastId)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        self.episodeCount = try container.decodeIfPresent(Int.self, forKey: .episodeCount)
        self.duration = try container.decodeIfPresent(Int.self, forKey: .duration)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.priority = try container.decodeIfPresent(Int.self, forKey: .priority)
        self.popularityScore = try container.decodeIfPresent(Int.self, forKey: .popularityScore)
        self.score = try container.decodeIfPresent(Double.self, forKey: .score)
        if let duration = duration {
            let (h, m) = splitDurationIntoHoursAndMinutes(from: duration)
            durationText = "\(h)س \(m)د"
        }

    }
}
