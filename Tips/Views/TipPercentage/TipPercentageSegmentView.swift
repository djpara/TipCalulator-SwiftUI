//
//  TipPercentageSegmentView.swift
//  Tips
//
//  Created by David Para on 6/3/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct TipPercentageSegmentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var amountViewModel: AmountViewModel
    @ObservedObject var tipConfig: TipConfig
    
    @State private var selectedSegmentValue: Double = 0
    @State private var showCustomized = false
    
    init(amountViewModel: AmountViewModel, tipConfig: TipConfig = .init()) {
        self.amountViewModel = amountViewModel
        self.tipConfig = tipConfig
    }
    
    var body: some View {
        let customBinding = Binding<String>(
            get: {
                if amountViewModel.tipPercentage < 1 { return "" }
                return "\(Int(amountViewModel.tipPercentage))"
            },
            set: {
                amountViewModel.tipPercentage = Double($0) ?? 0
            }
        )
        
        let selectedBinding = Binding<Double>(
            get: {
                selectedSegmentValue
            },
            set: {
                amountViewModel.tipPercentage = $0 < 1 ? 0 : $0
                selectedSegmentValue = $0
            }
        )
        
        return VStack {
            Picker("", selection: selectedBinding) {
                ForEach(tipConfig.tipOptions, id: \.tipPercentage) { tipViewModel in
                    Text(self.getTipPercentage(for: tipViewModel))
                }
            }.pickerStyle(SegmentedPickerStyle())
            if showCustomized {
                HStack {
                    TextField("Custom Tip %", text: customBinding)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                        .accentColor(colorScheme == .dark ? .white : .black)
                    if !customBinding.wrappedValue.isEmpty { Text("%").font(.footnote) }
                }.padding([.top, .bottom], 8)
            }
        }.onChange(of: selectedSegmentValue, perform: { value in
            withAnimation {
                showCustomized = value == -1
            }
        }).transition(.slide)
    }
    
    private func getTipPercentage(for tipViewModel: Tip) -> String {
        if tipViewModel.tipPercentage == -1 { return "Other" }
        return String(format: "%.f%@", tipViewModel.tipPercentage, "%")
    }
}

#if DEBUG
struct TipPercentageCellView_Previews: PreviewProvider {
    static var previews: some View {
        let amountViewModel = AmountViewModel(totalAmount: "",
                                              currencyFormatter: .makeCurrencyFormatter(using: .current))
        TipPercentageSegmentView(amountViewModel: amountViewModel)
    }
}
#endif
