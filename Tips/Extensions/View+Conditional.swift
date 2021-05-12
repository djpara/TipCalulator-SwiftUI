//
//  View+Conditional.swift
//  Tips
//
//  Created by David Para on 5/12/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import SwiftUI

extension View {
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            return AnyView(content(self))
        } else {
            return AnyView(self)
        }
    }
}
