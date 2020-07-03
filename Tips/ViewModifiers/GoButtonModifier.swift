//
//  GoButtonModifier.swift
//  Tips
//
//  Created by David Para on 7/2/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct GoButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
