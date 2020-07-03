//
//  NumberFormatter+Extensions.swift
//  Tips
//
//  Created by David Para on 5/26/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static func makeCurrencyFormatter(using locale: Locale) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = locale
        return formatter
    }
    
    static func makeSpellOutFormatter(using locale: Locale) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.maximumFractionDigits = 2
        formatter.locale = locale
        return formatter
    }
}
