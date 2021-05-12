//
//  SaveTransactionView.swift
//  Tips
//
//  Created by David Para on 5/10/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import CoreData
import SwiftUI

struct SaveTransactionView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var transactionName: String = ""

    @Binding var show: Bool

    var saveTransactionViewModel: SaveTransactionViewModel

    var body: some View {
        VStack {
            Text("File away as")
                .padding([.top], 16)
                .font(.body.weight(.semibold))
            TextField("Transaction name", text: $transactionName)
                .multilineTextAlignment(.center)
                .padding([.bottom], 8)
                .padding([.leading, .trailing], 16)
                .font(.footnote)
            Divider()
            HStack {
                Spacer()
                Button(
                    action: {
                        clear()
                    },
                    label: { Text("Cancel").foregroundColor(.red) }
                )
                Spacer()
                Divider().frame(height: 32)
                Spacer()
                Button(
                    action: {
                        saveTransactionViewModel.saveTransaction(named: transactionName)
                        clear()
                    },
                    label: { Text("Save") }
                )
                Spacer()
            }.padding([.bottom], 8)
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 0.25)
        )
        .shadow(color: colorScheme == .dark ? .clear : .gray, radius: 8, x: 1, y: 1)
    }

    private func clear() {
        UIApplication.closeAllKeyboards(.shared)
        transactionName = ""
        show.toggle()
    }
}


#if DEBUG
struct SaveTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        let store = TransactionStoreMock()
        let context = NSPersistentContainer.tips.viewContext
        let aViewModel = AmountViewModel(originalAmount: "$20.00",
                                         currencyFormatter: .makeCurrencyFormatter(using: .current))
        let sViewModel = SaveTransactionViewModel(amountViewModel: aViewModel,
                                                 transactionStore: store)
        return ForEach(ColorScheme.allCases,
                       id: \.self,
                       content: SaveTransactionView(show: .constant(true),
                                                    saveTransactionViewModel: sViewModel)
                        .frame(width: 250, height: 100)
                        .environment(\.managedObjectContext, context)
                        .preferredColorScheme)
    }
}
#endif
