//
//  ClearButtonModifier.swift
//  Tips
//
//  Created by David Para on 7/2/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct ClearButtonModifier: ViewModifier {
    @Binding var total: String
    var amountViewModel: AmountViewModel
    
    public func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
            // onTapGesture is better than a Button here when adding to a form
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.secondary)
                .onTapGesture {
                    self.total.removeAll()
                    self.amountViewModel.originalAmount = ""
                    self.amountViewModel.totalAmount = "$0.00"
                    self.amountViewModel.tip = 0
                    UIApplication.closeAllKeyboards(.shared)
            }
        }
    }
}
