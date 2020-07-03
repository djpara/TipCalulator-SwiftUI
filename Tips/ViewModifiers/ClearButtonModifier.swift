//
//  ClearButtonModifier.swift
//  Tips
//
//  Created by David Para on 7/2/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct ClearButtonModifier: ViewModifier {
    @Binding var text: String
    var totalViewModel: TotalViewModel
    
    public init(text: Binding<String>, totalViewModel: TotalViewModel) {
        self._text = text
        self.totalViewModel = totalViewModel
    }
    
    public func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
            // onTapGesture is better than a Button here when adding to a form
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.secondary)
                .onTapGesture {
                    self.text.removeAll()
                    self.totalViewModel.amount.removeAll()
                    UIApplication.closeAllKeyboards(.shared)
            }
        }
    }
}
