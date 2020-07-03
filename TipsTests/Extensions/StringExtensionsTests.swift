//
//  StringExtensionsTests.swift
//  TipsTests
//
//  Created by David Para on 5/28/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import XCTest

@testable import Tips

class StringExtensionsTests: XCTestCase {
    var currencyFormatter: NumberFormatter!
    var sut: String!
    
    override func setUp() {
        super.setUp()
        currencyFormatter = NumberFormatter.makeCurrencyFormatter(using: Locale(identifier: "en_US"))
    }
    
    override func tearDown() {
        currencyFormatter = nil
        sut = nil
        super.tearDown()
    }

    func test_convertForCurrency_stringWithSymbol_isEqual() {
        sut = "$6.23"
        let value = sut.convertForCurrency(using: currencyFormatter)
        
        XCTAssertEqual(value, "$6.23")
    }
    
    func test_convertForCurrency_stringWithoutSymbol_isEqual() {
        sut = "6.23"
        let value = sut.convertForCurrency(using: currencyFormatter)
        
        XCTAssertEqual(value, "$6.23")
    }
    
    func test_convertForCurrency_invalidString_nil() {
        sut = "Invalid"
        let value = sut.convertForCurrency(using: currencyFormatter)
        
        XCTAssertNil(value)
    }
}
