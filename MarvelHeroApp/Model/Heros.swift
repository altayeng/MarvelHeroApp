//
//  Heros.swift
//  MarvelHeroApp
//
//  Created by Altay Kırlı on 3.02.2022.
//

import Foundation

struct MCListCharactersResponse: Codable {
    let code: Int
    let status, copyright, attributionText: String
    let attributionHTML: String
    let data: DataClass
    let etag: String
}

struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [MCListCharacter]
}

struct MCListCharacter: Codable {
    let id: Int
    let name, resultDescription, modified: String
    let resourceURI: String
    let urls: [URLElement]
    let thumbnail: Thumbnail
    let comics: Comics
    let stories: Stories
    let events, series: Comics
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, resourceURI, urls, thumbnail, comics, stories, events, series
    }
    
    func getThumbnail() -> String {
        return "\(thumbnail.path).\(thumbnail.thumbnailExtension)".replacingOccurrences(of: "http://", with: "https://")
    }
}

//Comics
struct Comics: Codable {
    let available, returned: Int
    let collectionURI: String
    let items: [ComicsItem]
}

//ComicsItem
struct ComicsItem: Codable {
    let resourceURI, name: String
}

//Stories
struct Stories: Codable {
    let available, returned: Int
    let collectionURI: String
    let items: [StoriesItem]
}

//StoriesItem
struct StoriesItem: Codable {
    let resourceURI, name, type: String
}

//Thumbnail
struct Thumbnail: Codable {
    let path, thumbnailExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

//URLElement
struct URLElement: Codable {
    let type, url: String
}
