//
//  CalculateTotalButton.swift
//  Tips
//
//  Created by David Para on 7/1/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct CalculateTotalButton: View {
    var totalViewModel: TotalViewModel
    var selectedTipPercentage: Double
    var currencyFormatter: NumberFormatter
    
    @State private var tip = 0.0
    
    var body: some View {
        HStack {
            Text("Tip: \(currencyFormatter.string(from: tip.nsNumberValue) ?? "$0.00")")
            Spacer()
            Button(action: {
                let totalAmount = self.totalViewModel.amount.convertCurrencyToDouble(using: self.currencyFormatter)
                guard totalAmount != 0 else { return }
                self.tip = totalAmount * (self.selectedTipPercentage / 100)
                try? self.totalViewModel.add(self.tip)
            }) {
                Text("Calculate")
                    .modifier(GoButtonModifier())
            }.padding(16)
        }
    }
}

#if DEBUG
struct CalculateTotalButton_Previews: PreviewProvider {
    static var previews: some View {
        let currencyFormatter = NumberFormatter.makeCurrencyFormatter(using: .current)
        return CalculateTotalButton(totalViewModel: TotalViewModel(amount: "", currencyFormatter: currencyFormatter), selectedTipPercentage: 18, currencyFormatter: currencyFormatter)
    }
}
#endif
