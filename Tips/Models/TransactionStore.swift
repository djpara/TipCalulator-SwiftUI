//
//  TransactionStore.swift
//  Tips
//
//  Created by David Para on 5/9/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import CoreData
import Foundation

class TransactionStore: Store {
    private let fetchRequest = NSFetchRequest<Transaction>(entityName: "Transaction")
    
    var persistentContainer: NSPersistentContainer
    
    required init() {
        persistentContainer = NSPersistentContainer.tips
    }
    
    required init(persistentContainer: NSPersistentContainer,
                  inMemory: Bool = false) {
        self.persistentContainer = persistentContainer
        if inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            self.persistentContainer.persistentStoreDescriptions = [description]
        }
        self.persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            Log.debug(message: "Load transaction store successful: \(description)")
        }
    }
    
    func get(byID id: UUID, context: NSManagedObjectContext) -> Transaction? {
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            Log.error(message: "Could not load transaction with id: \(id)")
        }
        return nil
    }
    
    func save(_ model: Transaction, context: NSManagedObjectContext) {
        if context.hasChanges {
            do { try context.save() }
            catch { Log.error(message: "Could not save \(model)") }
        }
    }
}
