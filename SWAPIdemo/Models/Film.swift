//
//  Film.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/28.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import Foundation

struct Film: Codable {

    private enum CodingKeys: String, CodingKey {
        case episodeId = "episode_id"
        case title
        case openingCrawlText = "opening_crawl"
        case director
        case producer
        case releaseDate = "release_date"
        case characters
        case dateCreated = "created"
        case dateEdited = "edited"
    }
    
    let episodeId: Int
    let title: String
    let openingCrawlText: String
    let director: String
    let producer: String
    let releaseDate: String
    let characters: [String]
    let dateCreated: String
    let dateEdited: String
}
