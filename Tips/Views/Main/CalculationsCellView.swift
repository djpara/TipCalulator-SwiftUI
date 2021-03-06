//
//  CalculationsCellView.swift
//  Tips
//
//  Created by David Para on 8/16/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct CalculationsCellView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var amountViewModel: AmountViewModel
    var currencyFormatter: NumberFormatter { amountViewModel.currencyFormatter }
    
    var body: some View {
        VStack {
            HStack {
                Text("Tip:")
                    .font(.caption)
                    .padding()
                Spacer()
                Text("\(currencyFormatter.string(from: amountViewModel.tip.nsNumberValue) ?? "$0.00")")
                    .padding()
            }
            HStack {
                Text("Total:")
                    .font(.caption)
                    .padding()
                Spacer()
                Text("\(amountViewModel.totalAmount)")
                    .bold()
                    .font(.callout)
                    .padding()
            }
        }.overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(colorScheme == .dark ? Color.gray : Color.black, lineWidth: 1))
    }
}
