//
//  SWAPIdemoTests.swift
//  SWAPIdemoTests
//
//  Created by Ryan Dias on 2018/03/28.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import XCTest
@testable import SWAPIdemo

class SWAPIdemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    /*
     * Tests the DateFormatter extension's convenience initializer
     */
    func testDateFormatter() {
        
        let dateFormatter = DateFormatter(withFormat: "yyyy-MM-dd")
        
        XCTAssertNotNil(dateFormatter.string(from: Date()))
        XCTAssert(dateFormatter.string(from: Date()).count == 10)
    }
    
}
