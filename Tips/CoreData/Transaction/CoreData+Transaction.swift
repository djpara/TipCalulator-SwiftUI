//
//  CoreData+Transaction.swift
//  Tips
//
//  Created by David Para on 5/11/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import CoreData

extension Transaction {
    convenience init(name: String, from amountViewModel: AmountViewModel, in context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = UUID()
        self.name = name
        self.amount = amountViewModel.originalAmount.doubleValue ?? 0
        self.tipPercentage = amountViewModel.tipPercentage
        self.tip = amountViewModel.tip
        self.total = amountViewModel.totalAmount.doubleValue ?? 0
    }
}
