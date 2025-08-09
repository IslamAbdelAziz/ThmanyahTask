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

enum ContentType: String, Codable {
    case podcast
    case episode
    case audioBook = "audio_book"
    case audioArticle = "audio_article"
}

struct ModelSection : Decodable, Identifiable {
    let id = UUID()
    let name : String?
    let type : UIType?
    let contentType : ContentType?
    let order : Int?
    let content : [Any]?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type = "type"
        case contentType = "content_type"
        case order = "order"
        case content = "content"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.type = try container.decodeIfPresent(UIType.self, forKey: .type)
        self.contentType = try container.decodeIfPresent(ContentType.self, forKey: .contentType)
        if let content = try container.decodeIfPresent([ModelContentPodcast].self, forKey: .content) {
            self.content = content
        } else if let content = try container.decodeIfPresent([ModelContentAudioArticle].self, forKey: .content) {
            self.content = content
        } else if let content = try container.decodeIfPresent([ModelContentAudioBook].self, forKey: .content) {
            self.content = content
        } else if let content = try container.decodeIfPresent([ModelContentEpisode].self, forKey: .content) {
            self.content = content
        }else {
            self.content = nil
        }
        self.order = try container.decodeIfPresent(Int.self, forKey: .order)
    }
}
