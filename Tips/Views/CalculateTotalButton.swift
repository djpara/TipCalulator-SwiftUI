//
//  CalculateTotalButton.swift
//  Tips
//
//  Created by David Para on 7/1/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct CalculateTotalButton: View {
    @Binding var selectedTipPercentage: Double
    @Binding var customTipPercentage: Double?
    
    var amountViewModel: AmountViewModel
    var currencyFormatter: NumberFormatter
    
    var body: some View {
        HStack {
            Button(action: {
                calculate()
            }) {
                Text("Calculate")
                    .frame(maxWidth: .infinity)
                    .modifier(GoButtonModifier())
            }
        }
    }
    
    func calculate() {
        let totalAmount = self.amountViewModel.originalAmount.convertCurrencyToDouble(using: self.currencyFormatter)
        guard totalAmount != 0 else { return }
        var tipPercentage: Double? = selectedTipPercentage > 0 ? selectedTipPercentage : 0
        tipPercentage = customTipPercentage ?? 0 <= 0
            ? tipPercentage
            : customTipPercentage
        self.amountViewModel.tip = totalAmount * (tipPercentage! / 100)
        try? self.amountViewModel.add(self.amountViewModel.tip)
    }
}
