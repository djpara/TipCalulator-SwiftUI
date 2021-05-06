//
//  ClearTextFieldModifier.swift
//  Tips
//
//  Created by David Para on 7/2/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct ClearTextFieldModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .keyboardType(.numberPad)
            .foregroundColor(.clear)
            .accentColor(colorScheme == .dark ? .white : .black)
            .multilineTextAlignment(.trailing)
            .font(.title)
            .padding(10)
    }
}
