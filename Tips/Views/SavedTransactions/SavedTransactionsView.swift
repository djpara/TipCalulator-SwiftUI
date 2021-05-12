//
//  SavedTransactionsView.swift
//  Tips
//
//  Created by David Para on 5/11/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import CoreData
import SwiftUI

struct SavedTransactionsView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.colorScheme) var colorScheme
    
    var transactionStore: TransactionStore
    
    @FetchRequest(
        entity: Transaction.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.dateAdded, ascending: false)]
    ) var transactions: FetchedResults<Transaction>
    
    var body: some View {
        List {
            ForEach(transactions) { transaction in
                SavedTransactionCell(transaction: transaction)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .listRowInsets(EdgeInsets())
                    .background(colorScheme == .dark ? Color.black : Color.white)
            }
            .onDelete {
                transactionStore
                    .delete(at: $0, in: transactions, context: context)
            }
        }.navigationTitle(Text("Saved Transactions"))
    }
}

struct SavedTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        let context = NSPersistentContainer.tips.viewContext
        let transaction = Transaction(context: context)
        transaction.name = "This is a test transaction"
        transaction.dateAdded = Date()
        transaction.amount = "$20.00"
        transaction.tip = 5
        transaction.total = "$25.00"
        
        return ForEach(ColorScheme.allCases,
                       id: \.self,
                       content:
                        SavedTransactionsView(transactionStore: TransactionStoreMock())
                        .environment(\.managedObjectContext, context)
                        .preferredColorScheme)
    }
}
