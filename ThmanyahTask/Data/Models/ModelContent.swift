//
//  ModelContent.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import Foundation

struct BaseModelContent: Codable, Hashable {
//    let id: Int?
    let name : String?
    let avatarUrl : String?
    let duration : Int?
    var durationText : String?
    var authorName : String?
    
    var autherAndTitle: String? {
        if let authorName = authorName {
            return "\(authorName) | \(name ?? "")"
        }
        return "\(name ?? "")"
    }

    init(from podcast: ModelContentPodcast?) {
        name = podcast?.name
        avatarUrl = podcast?.avatarUrl
        duration = podcast?.duration
        durationText = podcast?.durationText
    }
    init(from audioBook: ModelContentAudioBook?) {
        name = audioBook?.name
        avatarUrl = audioBook?.avatarUrl
        duration = audioBook?.duration
        durationText = audioBook?.durationText
        authorName = audioBook?.authorName
    }
    init(from audioArticle: ModelContentAudioArticle?) {
        name = audioArticle?.name
        avatarUrl = audioArticle?.avatarUrl
        duration = audioArticle?.duration
        durationText = audioArticle?.durationText
        authorName = audioArticle?.authorName

    }
    init(from episode: ModelContentEpisode?) {
        name = episode?.name
        avatarUrl = episode?.avatarUrl
        duration = episode?.duration
        durationText = episode?.durationText
        authorName = episode?.authorName
    }
    
}

struct ModelContentPodcast: Codable, Identifiable {
    
    let podcastId : String?
    let id = UUID()
    let name : String?
    let avatarUrl : String?
    let duration : Int?
    var durationText : String?
    let description : String?
    let episodeCount : Int?
    let language : String?
    let priority : Int?
    let popularityScore : Int?
    let score : Double?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.podcastId = try container.decodeIfPresent(String.self, forKey: .podcastId)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        self.duration = try container.decodeIfPresent(Int.self, forKey: .duration)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.episodeCount = try container.decodeIfPresent(Int.self, forKey: .episodeCount)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.priority = try container.decodeIfPresent(Int.self, forKey: .priority)
        self.popularityScore = try container.decodeIfPresent(Int.self, forKey: .popularityScore)
        self.score = try container.decodeIfPresent(Double.self, forKey: .score)
        if let duration = duration {
            let (h, m) = splitDurationIntoHoursAndMinutes(from: duration)
            if h > 0 {
                durationText = "\(h)h \(m)m"
            } else {
                durationText = "\(m)m"
            }
        }
    }
}

struct ModelContentAudioBook : Codable, Identifiable {
    let id = UUID()
    let name : String?
    let avatarUrl : String?
    let duration : Int?
    var durationText : String?
    let audiobookId : String?
    let authorName : String?
    let description : String?
    let language : String?
    let releaseDate : String?
    let score : Int?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        self.duration = try container.decodeIfPresent(Int.self, forKey: .duration)
        self.audiobookId = try container.decodeIfPresent(String.self, forKey: .audiobookId)
        self.authorName = try container.decodeIfPresent(String.self, forKey: .authorName)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.score = try container.decodeIfPresent(Int.self, forKey: .score)
        if let duration = duration {
            let (h, m) = splitDurationIntoHoursAndMinutes(from: duration)
            if h > 0 {
                durationText = "\(h)h \(m)m"
            } else {
                durationText = "\(m)m"
            }
        }
    }
}

struct ModelContentAudioArticle : Codable, Identifiable {
    let id = UUID()
    let name : String?
    let avatarUrl : String?
    let duration : Int?
    var durationText : String?
    let articleId : String?
    let authorName : String?
    let description : String?
    let releaseDate : String?
    let score : Int?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        self.duration = try container.decodeIfPresent(Int.self, forKey: .duration)
        self.articleId = try container.decodeIfPresent(String.self, forKey: .articleId)
        self.authorName = try container.decodeIfPresent(String.self, forKey: .authorName)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.score = try container.decodeIfPresent(Int.self, forKey: .score)
        if let duration = duration {
            let (h, m) = splitDurationIntoHoursAndMinutes(from: duration)
            if h > 0 {
                durationText = "\(h)h \(m)m"
            } else {
                durationText = "\(m)m"
            }
        }
    }
}

struct ModelContentEpisode : Codable, Identifiable {
    let id = UUID()
    let name : String?
    let avatarUrl : String?
    let duration : Int?
    var durationText : String?

    let episodeId : String?
    let podcastPopularityScore : Int?
    let podcastPriority : Int?
    let seasonNumber : Int?
    let episodeType : String?
    let podcastName : String?
    let authorName : String?
    let description : String?
    let number : Int?
    let separatedAudioUrl : String?
    let audioUrl : String?
    let releaseDate : String?
    let podcastId : String?
    let score : Double?
    let episodeCount: Int?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        self.duration = try container.decodeIfPresent(Int.self, forKey: .duration)
        self.episodeId = try container.decodeIfPresent(String.self, forKey: .episodeId)
        self.podcastPopularityScore = try container.decodeIfPresent(Int.self, forKey: .podcastPopularityScore)
        self.podcastPriority = try container.decodeIfPresent(Int.self, forKey: .podcastPriority)
        self.seasonNumber = try container.decodeIfPresent(Int.self, forKey: .seasonNumber)
        self.episodeType = try container.decodeIfPresent(String.self, forKey: .episodeType)
        self.podcastName = try container.decodeIfPresent(String.self, forKey: .podcastName)
        self.authorName = try container.decodeIfPresent(String.self, forKey: .authorName)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.number = try container.decodeIfPresent(Int.self, forKey: .number)
        self.separatedAudioUrl = try container.decodeIfPresent(String.self, forKey: .separatedAudioUrl)
        self.audioUrl = try container.decodeIfPresent(String.self, forKey: .audioUrl)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.podcastId = try container.decodeIfPresent(String.self, forKey: .podcastId)
        self.score = try container.decodeIfPresent(Double.self, forKey: .score)
        self.episodeCount = try container.decodeIfPresent(Int.self, forKey: .episodeCount)
        
        if let duration = duration {
            let (h, m) = splitDurationIntoHoursAndMinutes(from: duration)
            if h > 0 {
                durationText = "\(h)h \(m)m"
            } else {
                durationText = "\(m)m"
            }
        }
    }
    
}


func splitDurationIntoHoursAndMinutes(from seconds: Int) -> (hours: Int, minutes: Int) {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    return (hours, minutes)
    
}
