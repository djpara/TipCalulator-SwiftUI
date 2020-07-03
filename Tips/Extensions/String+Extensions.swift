//
//  String+Extensions.swift
//  Tips
//
//  Created by David Para on 5/28/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import Foundation

extension String {
    var doubleValue: Double? {
        Double(self)
    }
    
    func convertForCurrency(using currencyFormatter: NumberFormatter) -> String? {
        let stringToDouble = currencyFormatter.number(from: self)?.doubleValue ?? Double(self)
        if let double = stringToDouble {
            return currencyFormatter.string(for: double)
        }
        
        return nil
    }
    
    func convertCurrencyToDouble(using currencyFormatter: NumberFormatter) -> Double {
        return currencyFormatter.number(from: self)?.doubleValue ?? 0
    }
}
