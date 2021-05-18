//
//  TransactionMoreDetailsView.swift
//  Tips
//
//  Created by David Para on 5/17/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import SwiftUI

struct SavedTransactionMoreDetailsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var context
    
    @Binding var showMoreDetails: Bool
    var transactionStore: TransactionStore
    var transaction: Transaction?
    
    var body: some View {
        let moreDetailsEditorBinding = Binding<String>(
            get: {
                return transaction?.moreDetails ?? ""
            },
            set: {
                transaction?.moreDetails = $0
            }
        )
        
        VStack {
            Text("Notes")
                .padding([.top])
                .font(.title2)
            Divider()
            TextEditor(text: moreDetailsEditorBinding)
                .font(.caption)
                .padding()
            Divider()
            HStack {
                Spacer()
                Button(
                    action: {
                        transaction?.managedObjectContext?.rollback()
                        showMoreDetails.toggle()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                )
                Spacer()
                Divider().frame(height: 32)
                Spacer()
                Button(
                    action: {
                        guard let transaction = transaction else { return }
                        transactionStore.save(transaction, context: context)
                        showMoreDetails.toggle()
                    }, label: {
                        Text("Save")
                    }
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
}

struct TransactionMoreDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let transactionStoreMock = TransactionStoreMock()
        let context = transactionStoreMock.persistentContainer.viewContext
        let transaction = Transaction(context: context)
        transaction.name = "New Transaction"
        transaction.moreDetails = "Here are some more details about this particular transaction. I was able to split the transaction with a friend quite easily. This was good stuff."
        transaction.amount = "$20.00"
        transaction.tipPercentage = 25
        transaction.tip = 5
        transaction.total = "$25.00"
        
        return SavedTransactionMoreDetailsView(showMoreDetails: .constant(true),
                                          transactionStore: transactionStoreMock,
                                          transaction: transaction)
            .environment(\.managedObjectContext, context)
    }
}
