//
//  NewsModel.swift
//  Coingate
//
//  Created by Victor on 28/10/2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let news = try? JSONDecoder().decode(News.self, from: jsonData)

import Foundation

// MARK: - Result
struct NewsModel: Hashable, Codable {
    let articleID, title: String?
    let link: String?
    let keywords, creator: [String]?
    let description, content, pubDate: String?
    let imageURL: String?
    let sourceID: String?
    let sourcePriority: Int?
    let country: [String]?

    enum CodingKeys: String, CodingKey {
        case articleID = "article_id"
        case title, link, keywords, creator
        case description, content, pubDate
        case imageURL = "image_url"
        case sourceID = "source_id"
        case sourcePriority = "source_priority"
        case country
    }

    // Implement the hash(into:) method to make the struct Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(articleID ?? "")
        hasher.combine(title ?? "")
        hasher.combine(link ?? "")
        hasher.combine(keywords ?? [])
        hasher.combine(creator ?? [])
        hasher.combine(description ?? "")
        hasher.combine(content ?? "")
        hasher.combine(pubDate ?? "")
        hasher.combine(imageURL ?? "")
        hasher.combine(sourceID ?? "")
        hasher.combine(sourcePriority ?? 0)
        hasher.combine(country ?? [])
    }
}



