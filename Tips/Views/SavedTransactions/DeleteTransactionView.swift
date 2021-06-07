//
//  DeleteTransactionView.swift
//  Tips
//
//  Created by David Para on 6/7/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import SwiftUI

struct DeleteTransactionView: View {
    @Environment(\.colorScheme) var colorScheme 
    
    private var completion: ((Bool) -> Void)?
    private var isPresented: Binding<Bool>
    
    init(isPresented: Binding<Bool>, completion: ((Bool) -> Void)? = nil) {
        self.isPresented = isPresented
        self.completion = completion
    }
    
    var body: some View {
        VStack {
            Text("DeleteTransaction")
                .padding([.top, .bottom], 16)
                .font(.body.weight(.semibold))
            Text("Are you sure you want to delete this transaction?")
                .multilineTextAlignment(.center)
                .padding([.bottom], 8)
                .padding([.leading, .trailing], 16)
                .font(.footnote)
            Divider()
            HStack {
                Spacer()
                Button(
                    action: {
                        self.completion?(false)
                    },
                    label: { Text("Cancel") }
                )
                Spacer()
                Divider().frame(height: 32)
                Spacer()
                Button(
                    action: {
                        self.completion?(true)
                    },
                    label: { Text("Delete").foregroundColor(.red) }
                )
                Spacer()
            }.padding([.bottom], 8)
        }
        .frame(width: 250)
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 0.25)
        )
        .shadow(color: colorScheme == .dark ? .clear : .gray, radius: 8, x: 1, y: 1)
    }
}

struct DeleteTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteTransactionView(isPresented: .constant(true))
    }
}
