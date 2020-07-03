//
//  TotalViewModel.swift
//  Tips
//
//  Created by David Para on 6/3/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import Foundation

class TotalViewModel: ObservableObject {
    @Published var amount: String
    private(set) var currencyFormatter: NumberFormatter
    
    init(amount: String, currencyFormatter: NumberFormatter) {
        self.amount = amount
        self.currencyFormatter = currencyFormatter
        
        if let number = self.convertToDouble(amount)?.nsNumberValue, number != 0 {
            self.amount = currencyFormatter.string(from: number) ?? ""
        }
    }
    
    func add(_ amountToAdd: Double) throws {
        if amount == "" { amount = "0" }
        guard let amountToDouble = convertToDouble(amount) else {
            throw AmountTotalError.add("'\(amount)' is not convertible to Double")
        }
        let addedAmount = amountToDouble + amountToAdd
        amount = currencyFormatter.string(for: addedAmount)!
    }
    
    func subtract(_ amountToSubtract: Double) throws {
        if amount == "" { amount = "0" }
        guard let amountToDouble = convertToDouble(amount) else {
            throw AmountTotalError.subtract("'\(amount)' is not convertible to Double")
        }
        let subtractedAmount = amountToDouble - amountToSubtract
        amount = currencyFormatter.string(for: subtractedAmount)!
    }
    
    func convertToDouble(_ expression: String) -> Double? {
        if let double = expression.doubleValue ?? currencyFormatter.number(from: amount)?.doubleValue {
            return double
        }
        
        return nil
    }
}
