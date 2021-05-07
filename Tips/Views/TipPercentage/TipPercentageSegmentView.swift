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
    
    @ObservedObject var tipListViewModel: TipListViewModel
    @Binding var selectedTipPercentage: Double
    @Binding var customTipPercentage: Double?
    @State private(set) var showCustomized = false
    
    var body: some View {
        let customBinding = Binding<String>(
            get: {
                guard let customTipPercentage = customTipPercentage else { return "" }
                return "\(Int(customTipPercentage))"
            },
            set: {
                selectedTipPercentage = -1
                customTipPercentage = Double($0.replacingOccurrences(of: "%", with: ""))
            }
        )
        
        let selectedBinding = Binding<Double>(
            get: { selectedTipPercentage },
            set: {
                customTipPercentage = nil
                selectedTipPercentage = $0
            }
        )
        
        return VStack {
            Picker("", selection: selectedBinding) {
                ForEach(tipListViewModel.tipOptions, id: \.tipPercentage) { tipViewModel in
                    Text(self.getTipPercentage(for: tipViewModel))
                }
            }.pickerStyle(SegmentedPickerStyle())
            if showCustomized {
                HStack {
                    ZStack {
                        TextField("Custom Tip %", text: customBinding)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .accentColor(colorScheme == .dark ? .white : .black)
                    }
                    if customTipPercentage != nil { Text("%") }
                }.padding([.top], 8)
            }
        }.onChange(of: selectedTipPercentage, perform: { value in
            showCustomized = value == -1
        })
    }
    
    func getTipPercentage(for tipViewModel: TipViewModel) -> String {
        if tipViewModel.tipPercentage == -1 { return "Other" }
        return String(format: "%.f%@", tipViewModel.tipPercentage, "%")
    }
}

#if DEBUG
struct TipPercentageCellView_Previews: PreviewProvider {
    static var previews: some View {
        TipPercentageSegmentView(tipListViewModel: TipListViewModel(),
                                 selectedTipPercentage: .constant(15),
                                 customTipPercentage: .constant(0))
    }
}
#endif
