//
//  CalculateTotalButton.swift
//  Tips
//
//  Created by David Para on 7/1/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct CalculateTotalButton: View {
    var amountViewModel: AmountViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                amountViewModel.calculate()
            }) {
                Text("Calculate")
                    .frame(maxWidth: .infinity)
                    .modifier(GoButtonModifier())
            }
        }
    }
}
