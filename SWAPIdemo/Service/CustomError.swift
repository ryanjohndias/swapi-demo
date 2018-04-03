//
//  CustomError.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/04/03.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import Foundation

class CustomError: LocalizedError {

    var reason: String = ""
    
    public var errorDescription: String? {
        return reason
    }
    
    convenience init(withDescription description: String) {
        self.init()
        self.reason = description
    }
    
}
