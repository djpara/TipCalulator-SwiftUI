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
    
    var amountViewModel: AmountViewModel
    var currencyFormatter: NumberFormatter
    
    var body: some View {
        HStack {
            Button(action: {
                let totalAmount = self.amountViewModel.originalAmount.convertCurrencyToDouble(using: self.currencyFormatter)
                guard totalAmount != 0 else { return }
                self.amountViewModel.tip = totalAmount * (self.selectedTipPercentage / 100)
                try? self.amountViewModel.add(self.amountViewModel.tip)
            }) {
                Text("Calculate")
                    .frame(maxWidth: .infinity)
                    .modifier(GoButtonModifier())
            }
        }
    }
}
