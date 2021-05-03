//
//  CurrencyViewModel.swift
//  Tips
//
//  Created by David Para on 6/3/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import Foundation

class AmountViewModel: ObservableObject {
    @Published var totalAmount: String
    
    var originalAmount: String
    var tip: Double
    
    private(set) var currencyFormatter: NumberFormatter
    
    init(totalAmount: String, currencyFormatter: NumberFormatter) {
        self.totalAmount = "$0.00"
        self.originalAmount = totalAmount
        self.tip = 0
        self.currencyFormatter = currencyFormatter
        
        if let number = self.convertToDouble(totalAmount)?.nsNumberValue, number != 0 {
            self.totalAmount = currencyFormatter.string(from: number) ?? ""
        }
    }
    
    func add(_ amountToAdd: Double) throws {
        if originalAmount == "" { originalAmount = "0" }
        guard let amountToDouble = convertToDouble(originalAmount) else {
            throw AmountTotalError.add("'\(originalAmount)' is not convertible to Double")
        }
        let addedAmount = amountToDouble + amountToAdd
        totalAmount = currencyFormatter.string(for: addedAmount)!
    }
    
    func subtract(_ amountToSubtract: Double) throws {
        if originalAmount == "" { originalAmount = "0" }
        guard let amountToDouble = convertToDouble(originalAmount) else {
            throw AmountTotalError.subtract("'\(originalAmount)' is not convertible to Double")
        }
        let subtractedAmount = amountToDouble - amountToSubtract
        totalAmount = currencyFormatter.string(for: subtractedAmount)!
    }
    
    func convertToDouble(_ expression: String) -> Double? {
        if let double = expression.doubleValue ?? currencyFormatter.number(from: originalAmount)?.doubleValue {
            return double
        }
        
        return nil
    }
}
