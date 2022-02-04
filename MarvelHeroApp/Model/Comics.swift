//
//  Comics.swift
//  MarvelHeroApp
//
//  Created by Altay Kırlı on 3.02.2022.
//

import Foundation

 struct ComicsServerModel: Codable {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var etag: String?
    var data: ComicData

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case status = "status"
        case copyright = "copyright"
        case attributionText = "attributionText"
        case attributionHTML = "attributionHTML"
        case etag = "etag"
        case data = "data"
    }
}

 struct ComicData: Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [ComicResult]?

    enum CodingKeys: String, CodingKey {
        case offset = "offset"
        case limit = "limit"
        case total = "total"
        case count = "count"
        case results = "results"
    }
}

 struct ComicResult: Codable {
    var id: Int?
    var digitalId: Int?
    var title: String?
    var issueNumber: Int?
    var variantDescription: String?
    var resultDescription: String?
    var modified: String?
    var isbn: String?
    var upc: String?
    var diamondCode: String?
    var ean: String?
    var issn: String?
    var format: String?
    var pageCount: Int?
    var textObjects: [TextObject]?
    var resourceURI: String?
    var urls: [URLElement]?
    var series: Series?
    var variants: [Series]?
    var collections: [Series]?
    var collectedIssues: [Series]?
    var dates: [DateElement]?
    var prices: [Price]?
    var thumbnail: Thumbnail?
    var images: [Thumbnail]?
    var creators: Creators?
    var characters: Characters?
    var stories: Stories?
    var events: Characters?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case digitalId = "digitalId"
        case title = "title"
        case issueNumber = "issueNumber"
        case variantDescription = "variantDescription"
        case resultDescription = "description"
        case modified = "modified"
        case isbn = "isbn"
        case upc = "upc"
        case diamondCode = "diamondCode"
        case ean = "ean"
        case issn = "issn"
        case format = "format"
        case pageCount = "pageCount"
        case textObjects = "textObjects"
        case resourceURI = "resourceURI"
        case urls = "urls"
        case series = "series"
        case variants = "variants"
        case collections = "collections"
        case collectedIssues = "collectedIssues"
        case dates = "dates"
        case prices = "prices"
        case thumbnail = "thumbnail"
        case images = "images"
        case creators = "creators"
        case characters = "characters"
        case stories = "stories"
        case events = "events"
    }
    
    
    
}

 struct Characters: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [Series]?
    var returned: Int?

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

 struct Series: Codable {
    var resourceURI: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
    }
}

 struct Creators: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [CreatorsItem]?
    var returned: Int?

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

 struct CreatorsItem: Codable {
    var resourceURI: String?
    var name: String?
    var role: String?

    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
        case role = "role"
    }
}

 struct DateElement: Codable {
    var type: String?
    var date: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case date = "date"
    }
}

 struct Price: Codable {
    var type: String?
    var price: Double?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case price = "price"
    }
}

 struct TextObject: Codable {
    var type: String?
    var language: String?
    var text: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case language = "language"
        case text = "text"
    }
}

