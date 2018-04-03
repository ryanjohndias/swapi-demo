//
//  FilmsResponse.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/28.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import Foundation

struct FilmsResponse: Codable {

    let count: Int
    let next: String?
    let previous: String?
    let results: [Film]
}
