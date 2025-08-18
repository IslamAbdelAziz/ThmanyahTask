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
    let content : [MixedContentValue]?
    
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
        self.content = try container.decodeIfPresent([MixedContentValue].self, forKey: .content)
        self.order = try container.decodeIfPresent(Int.self, forKey: .order)
    }
}

enum MixedContentValue: Decodable, Hashable, Identifiable {
    case podcast(ModelContentPodcast)
    case audioArticle(ModelContentAudioArticle)
    case audioBook (ModelContentAudioBook)
    case episode(ModelContentEpisode)
            
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let podcast = try? container.decode(ModelContentPodcast.self) {
            self = .podcast(podcast)
        } else if let article = try? container.decode(ModelContentAudioArticle.self) {
            self = .audioArticle(article)
        }  else if let book = try? container.decode(ModelContentAudioBook.self) {
            self = .audioBook(book)
        }  else if let episode = try? container.decode(ModelContentEpisode.self) {
            self = .episode(episode)
        } else {
            throw DecodingError.typeMismatch(
                MixedContentValue.self,
                .init(codingPath: decoder.codingPath,
                      debugDescription: "Unsupported JSON type")
            )
        }
    }
    
    var id: UUID {
        switch self {
        case .podcast(let podcast):
            return podcast.id
        case .audioArticle(let article):
            return article.id
        case .audioBook(let book):
            return book.id
        case .episode(let episode):
            return episode.id
        }
    }
    

    var name: String {
        switch self {
        case .podcast(let podcast):
            return podcast.name ?? ""
        case .audioArticle(let article):
            return article.name ?? ""
        case .audioBook(let book):
            return book.name ?? ""
        case .episode(let episode):
            return episode.name ?? ""
        }
    }
    
    var avatarUrl: String {
        switch self {
        case .podcast(let podcast):
            return podcast.avatarUrl ?? ""
        case .audioArticle(let article):
            return article.avatarUrl ?? ""
        case .audioBook(let book):
            return book.avatarUrl ?? ""
        case .episode(let episode):
            return episode.avatarUrl ?? ""
        }
    }
    
    var duration: Int? {
        switch self {
        case .podcast(let podcast):
            return podcast.duration
        case .audioArticle(let article):
            return article.duration
        case .audioBook(let book):
            return book.duration
        case .episode(let episode):
            return episode.duration
        }
    }
    
    var durationText: String {
        switch self {
        case .podcast(let podcast):
            return podcast.durationText ?? ""
        case .audioArticle(let article):
            return article.durationText ?? ""
        case .audioBook(let book):
            return book.durationText ?? ""
        case .episode(let episode):
            return episode.durationText ?? ""
        }
    }
    
    var authorName: String {
        switch self {
        case .podcast(let podcast):
            return ""
        case .audioArticle(let article):
            return article.authorName ?? ""
        case .audioBook(let book):
            return book.authorName ?? ""
        case .episode(let episode):
            return episode.authorName ?? ""
        }
    }
    
    var autherAndTitle: String {
        switch self {
        case .podcast(let podcast):
            return name
        case .audioArticle(let article):
            if let authorName = article.authorName {
                return "\(authorName) | \(name)"
            }
            return name
        case .audioBook(let book):
            if let authorName = book.authorName {
                return "\(authorName) | \(name)"
            }
            return name
            
        case .episode(let episode):
            if let authorName = episode.authorName {
                return "\(authorName) | \(name)"
            }
            return name
        }
    }
}

