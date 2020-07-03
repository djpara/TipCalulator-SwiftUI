//
//  ClearTextFieldModifier.swift
//  Tips
//
//  Created by David Para on 7/2/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct ClearTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .keyboardType(.numberPad)
            .foregroundColor(.clear)
            .accentColor(.clear)
            .multilineTextAlignment(.center)
            .font(.title)
            .padding(20)
    }
}
