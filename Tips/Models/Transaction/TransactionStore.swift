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
    
    let container: NSPersistentContainer
    var context: NSManagedObjectContext?
    
    required init(inMemory: Bool = false,
         with container: NSPersistentContainer = .tips,
         contextType: ManagedObjectContextType = .main) {
        self.container = container
        self.container.loadPersistentStores { [weak self] description, error in
            if let error = error {
                Log.error(message: "Transaction store could not load: \(error)")
            }
            self?.context = NSManagedObjectContext.context(for: contextType, container: container)
            Log.debug(message: "Load transaction store successful: \(description)")
        }
    }
    
    func get(byID id: UUID) -> Transaction? {
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            return try context?.fetch(fetchRequest).first
        } catch {
            Log.error(message: "Could not load transaction with id: \(id)")
        }
        return nil
    }
    
    func save(_ model: Transaction) {
        if context?.hasChanges ?? false {
            do { try context?.save() }
            catch { Log.error(message: "Could not save \(model)") }
        }
    }
}
