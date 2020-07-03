//
//  TotalCellView.swift
//  Tips
//
//  Created by David Para on 6/1/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct TotalCellView: View {
    @State var total: String
    var totalViewModel: TotalViewModel
    
    let currencyFormatter: NumberFormatter
    
    private func formattedTotal(for double: Double) -> String {
        let hundredth = double / 100
        return currencyFormatter.string(from: hundredth.nsNumberValue) ?? ""
    }
    
    var body: some View {
        let bindingProxy = Binding<String>(
            get: { self.total },
            set: {
                self.total = $0
                
                guard let totalStringToDouble = self.total.doubleValue else {
                    self.totalViewModel.amount = ""
                    return
                }
                guard totalStringToDouble < 1_000_000_000_000 else {
                    self.total.removeLast()
                    return
                }
                
                self.totalViewModel.amount = self.formattedTotal(for: totalStringToDouble)
        })
        
        let placeholder = currencyFormatter.string(from: 0) ?? ""
        
        return VStack {
            ZStack(alignment: .center) {
                TextField(placeholder, text: bindingProxy)
                    .modifier(ClearTextFieldModifier())
                    .modifier(ClearButtonModifier(text: $total, totalViewModel: totalViewModel))
                Text(totalViewModel.amount)
                    .font(.title)
            }
        }
    }
}

#if DEBUG
struct TotalCellView_Previews: PreviewProvider {
    static var previews: some View {
        let locale = Locale(identifier: "en_GB")
        let currencyFormatter = NumberFormatter.makeCurrencyFormatter(using: locale)
        let totalViewModel = TotalViewModel(amount: "", currencyFormatter: currencyFormatter)
        return TotalCellView(total: totalViewModel.amount, totalViewModel: totalViewModel,
                      currencyFormatter: NumberFormatter.makeCurrencyFormatter(using: .current))
            .previewLayout(.sizeThatFits)
    }
}
#endif
