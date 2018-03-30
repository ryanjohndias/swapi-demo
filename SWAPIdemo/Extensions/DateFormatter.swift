//
//  DateFormatter.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/30.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import Foundation

extension DateFormatter {

    convenience init(withFormat format: String) {
        self.init()
        dateFormat = format
    }
    
}
