//
//  Transaction+Memento.swift
//  Tips
//
//  Created by David Para on 5/17/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import Foundation

extension Transaction {
    var copy: Transaction? {
        guard let context = managedObjectContext else { return nil }
        let transaction = Transaction(context: context)
        transaction.id = id
        transaction.name = name
        transaction.dateAdded = dateAdded
        transaction.amount = amount
        transaction.tipPercentage = tipPercentage
        transaction.tip = tip
        transaction.total = total
        transaction.moreDetails = moreDetails
        return transaction
    }
}
