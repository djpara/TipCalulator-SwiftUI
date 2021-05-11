//
//  TransactionStore.swift
//  Tips
//
//  Created by David Para on 5/9/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import CoreData
import Foundation

protocol TransactionFetching {
    func get(byID id: UUID) -> Transaction?
}

protocol TransactionSaving {
    func save(_ transaction: Transaction)
}

typealias TransactionAccessing = TransactionFetching & TransactionSaving

class TransactionStore: TransactionAccessing {
    private let fetchRequest = NSFetchRequest<Transaction>(entityName: "Transaction")
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(inMemory: Bool = false,
         with container: NSPersistentContainer = .tips,
         contextType: ManagedObjectContextType = .main) {
        self.container = container
        self.context = NSManagedObjectContext.context(for: contextType, container: container)
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/tips/transactions")
        }
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                Log.error(message: "Transaction store could not load: \(error)")
//            }
//            Log.debug(message: "Load transaction store successful: \(description)")
//        }
    }
    
    func makeTransaction(amount: Double, tipPercentage: Double, tip: Double, total: Double) -> Transaction? {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Transaction", in: context),
              let transaction = NSManagedObject(entity: entityDescription, insertInto: context) as? Transaction else {
            Log.error(message: "Could not create Transaction")
            return nil
        }
        
        transaction.amount = amount
        transaction.tipPercentage = tipPercentage
        transaction.tip = tip
        transaction.total = total
        
        return transaction
    }
    
    func get(byID id: UUID) -> Transaction? {
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            Log.error(message: "Could not load transaction with id: \(id)")
        }
        return nil
    }
    
    func save(_ transaction: Transaction) {
        if context.hasChanges {
            context.performAndWait {
                do { try context.save() }
                catch { Log.error(message: "Could not save \(transaction)") }
            }
        }
    }
}
