//
//  SpellOutCurrency.swift
//  Tips
//
//  Created by David Para on 6/14/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import Foundation

@propertyWrapper
struct SpellOutCurrency {
    private (set) var value: NSNumber = 0
    var currencyFormatter = NumberFormatter.makeCurrencyFormatter(using: .current)
    var spellOutFormatter = NumberFormatter.makeSpellOutFormatter(using: .current)
    
    var wrappedValue: String {
        get {
            guard value != 0 else {
                return "zero"
            }
            
            let wholeValue = value.intValue
            let decimalValue = decimal(for: value)
            
            let wholeValueString = spellOutFormatter.string(from: NSNumber(value: wholeValue)) ?? "zero"
            let decimalValueString = "\(decimalValue)/100"
            return "\(wholeValueString) and \(decimalValueString)"
        }
        set { value = currencyFormatter.number(from: newValue) ?? 0 }
    }

    private func decimal(for number: NSNumber) -> Int {
        let wholeNumber = number.intValue
        let decimal = (number.doubleValue - Double(wholeNumber)) * 100
        return Int(decimal.rounded(.toNearestOrAwayFromZero))
    }
}
