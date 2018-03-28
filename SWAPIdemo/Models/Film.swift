//
//  Film.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/28.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import Foundation

struct Film: Codable {

    let episode_id: String
    let title: String
    let opening_crawl: String
    let director: String
    let producer: String
    let release_date: String
    let created: Date
    let edited: Date
    
}
