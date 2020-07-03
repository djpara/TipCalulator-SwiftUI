//
//  TipViewModelTests.swift
//  TipsTests
//
//  Created by David Para on 6/20/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import XCTest

@testable import Tips

class TipViewModelTests: XCTestCase {
    var sut: TipViewModel!
    
    override func setUp() {
        super.setUp()
        
        sut = TipViewModel(tip: Tip(percentage: 0.15, rating: 1))
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
