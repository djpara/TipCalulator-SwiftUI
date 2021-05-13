//
//  BillAmountView.swift
//  Tips
//
//  Created by David Para on 6/1/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct BillAmountView: View {
    @ObservedObject var amountViewModel: AmountViewModel
    
    @State var total: String = ""
    
    var currencyFormatter: NumberFormatter { amountViewModel.currencyFormatter }
    
    init(amountViewModel: AmountViewModel) {
        self.amountViewModel = amountViewModel
        self.total = amountViewModel.originalAmount
    }
    
    private func formattedTotal(for double: Double) -> String {
        let hundredth = double / 100
        return currencyFormatter.string(from: hundredth.nsNumberValue) ?? ""
    }
    
    var body: some View {
        let bindingProxy = Binding<String>(
            get: { self.total },
            set: {
                self.total = $0

                guard self.total.last?.isNumber ?? true else { // keep true so that it doesn't remove an index that doesn't exist
                    self.total.removeLast()
                    return
                }

                guard let totalStringToDouble = self.total.doubleValue else {
                    self.amountViewModel.originalAmount = ""
                    return
                }

                guard totalStringToDouble < 1_000_000_000_000 else {
                    self.total.removeLast()
                    return
                }

                self.amountViewModel.originalAmount = self.formattedTotal(for: totalStringToDouble)
        })

        let placeholder = currencyFormatter.string(from: 0) ?? ""
        
        return HStack {
            Text("Amount:").padding([.leading], 16).font(.footnote)
            ZStack(alignment: .trailing) {
                TextField(placeholder,
                          text: bindingProxy)
                    .modifier(ClearTextFieldModifier())
                    .modifier(ClearButtonModifier(total: $total,
                                                  amountViewModel: amountViewModel))
                    .foregroundColor(.clear)
                Text(amountViewModel.originalAmount)
                    .font(.title)
                    .padding([.trailing], 34)
            }
        }
    }
}

#if DEBUG
struct BillAmountView_Previews: PreviewProvider {
    static var previews: some View {
        let amountViewModel = AmountViewModel(originalAmount: "$20.00",
                                              currencyFormatter: .makeCurrencyFormatter(using: .current))
        return BillAmountView(amountViewModel: amountViewModel)
    }
}
#endif
