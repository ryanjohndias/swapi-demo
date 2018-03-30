//
//  OMDBSearchResult.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/28.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import Foundation

struct OMDBSearchResult: Codable {
    
    let Search: [OMDBSearchFilm]
    let totalResults: String
    let Response: String
}

struct OMDBSearchFilm: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case resultType = "Type"
        case posterUrl = "Poster"
    }
    
    let title: String
    let year: String
    let imdbId: String
    let resultType: String
    let posterUrl: String
}
