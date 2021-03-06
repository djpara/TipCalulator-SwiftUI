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
    
    @State private var selectedTransaction: Transaction? = nil
    @State private var indexToDelete: IndexSet? = nil
    @State private var showDeleteAlert = false
    
    var transactionStore: TransactionStore
    
    private var descriptionTextWidth: CGFloat {
        UIScreen.main.bounds.width/2
    }
    
    @FetchRequest(
        entity: Transaction.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.dateAdded, ascending: false)]
    ) var transactions: FetchedResults<Transaction>
    
    var body: some View {
        VStack {
            List {
                ForEach(transactions) { transaction in
                    HStack {
                        SavedTransactionCell(transaction: .constant(transaction))
                        Button(action: {
                            selectedTransaction = transaction
                        }, label: {
                            Image(systemName: "info.circle").foregroundColor(.blue)
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8))
                    .listRowInsets(EdgeInsets())
                    .background(colorScheme == .dark ? Color.black : Color.white)
                }
                .onDelete {
                    indexToDelete = $0
                    showDeleteAlert.toggle()
                }
//                .alert(isPresented: $showDeleteAlert) {
//                    Alert(title: Text("Delete Transaction"),
//                          message: Text("Are you sure you want to delete this transaction?"),
//                          primaryButton: .destructive(Text("Delete")) {
//                            transactionStore.delete(at: indexToDelete!, in: transactions, context: context)
//                            indexToDelete = nil
//                            showDeleteAlert.toggle()
//                          },
//                          secondaryButton: .cancel(Text("Cancel")))
//                }
            }
            .popup(isPresented: showDeleteAlert) {
                DeleteTransactionView(isPresented: $showDeleteAlert) { delete in
                    showDeleteAlert.toggle()
                    guard delete, let indexToDelete = indexToDelete else { return }
                    transactionStore.delete(at: indexToDelete, in: transactions, context: context)
                }
            }
            .navigationTitle(Text("Saved Transactions"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .popup(isPresented: selectedTransaction != nil,
               alignment: .center,
               direction: .bottom,
               content: {
                SavedTransactionDetailsView(transaction: $selectedTransaction,
                                            transactionStore: transactionStore)
                    .frame(width: 300, alignment: .center)
               })
    }
}

#if DEBUG
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
#endif
