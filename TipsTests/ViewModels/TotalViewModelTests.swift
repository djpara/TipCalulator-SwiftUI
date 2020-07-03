//
//  TotalViewModelTests.swift
//  TipsTests
//
//  Created by David Para on 5/25/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import XCTest

@testable import Tips

class TotalViewModelTests: XCTestCase {
    var sut: TotalViewModel!
    
    override func setUp() {
        super.setUp()
        
        let numberFormatter = NumberFormatter.makeCurrencyFormatter(using: .current)
        sut = TotalViewModel(amount: "", currencyFormatter: numberFormatter)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func test_init_emptryString_isEqual() {
        XCTAssertEqual(sut.amount, "")
    }
    
    func test_add_correctNumberFormatter_isEqual() {
        try! sut.add(2.34)
        
        XCTAssertEqual(sut.amount, "$2.34")
    }
    
    func test_add_notDoubleConvertible_trowsError() {
        sut.amount = "Not a Double"
        
        XCTAssertThrowsError(try sut.add(2.34))
    }
    
    func test_add_gbLocale_isEqual() {
        let locale = Locale(identifier: "en_GB")
        let numberFormatter = NumberFormatter.makeCurrencyFormatter(using: locale)
        sut = TotalViewModel(amount: "", currencyFormatter: numberFormatter)
        
        try! sut.add(1)
        
        XCTAssertEqual(sut.amount, "£1.00")
    }
    
    func test_Subtract_CorrectNumberFormatter() {
        try! sut.subtract(2.34)
        
        XCTAssertEqual(sut.amount, "-$2.34")
    }
    
    func test_Subtract_WrongNumberFormatter() {
        sut = TotalViewModel(amount: "", currencyFormatter: NumberFormatter())
        
        XCTAssertNotEqual(sut.amount, "$2.34")
    }
    
    func test_Subtract_NonDoubleConvertible() {
        sut.amount = "Not a Double"
        
        XCTAssertThrowsError(try sut.subtract(2.34))
    }
}
