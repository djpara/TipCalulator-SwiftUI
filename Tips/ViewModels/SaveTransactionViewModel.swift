//
//  SaveTransactionViewModel.swift
//  Tips
//
//  Created by David Para on 5/12/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import SwiftUI
import Foundation

class SaveTransactionViewModel {
    @ObservedObject private var amountViewModel: AmountViewModel
    
    private var transactionStore: TransactionStore
    
    init(amountViewModel: AmountViewModel,
         transactionStore: TransactionStore = TransactionStore(persistentContainer: .tips,
                                                               inMemory: false)) {
        self.amountViewModel = amountViewModel
        self.transactionStore = transactionStore
    }
    
    func saveTransaction(named name: String) {
        let transaction = Transaction(context: transactionStore.persistentContainer.viewContext)
        transaction.id = UUID()
        transaction.dateAdded = Date()
        transaction.name = name
        transaction.amount = amountViewModel.originalAmount
        transaction.tipPercentage = amountViewModel.tipPercentage
        transaction.tip = amountViewModel.tip
        transaction.total = amountViewModel.totalAmount
        transactionStore.save(transaction, context: transactionStore.persistentContainer.viewContext)
    }
}
