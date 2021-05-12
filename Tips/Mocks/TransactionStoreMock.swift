//
//  TransactionStoreMock.swift
//  TipsTests
//
//  Created by David Para on 5/12/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import CoreData

class TransactionStoreMock: TransactionStore {
    var didLoadModel = false
    var didSaveModel = false
    
    required init() {
        super.init()
        self.persistentContainer = persistentContainer
    }
    
    required init(persistentContainer: NSPersistentContainer, inMemory: Bool = false) {
        fatalError("init(persistentContainer:inMemory:) has not been implemented")
    }
    
    override func get(byID id: UUID, context: NSManagedObjectContext) -> Transaction? {
        didLoadModel = true
        return nil
    }
    
    override func save(_ model: Transaction, context: NSManagedObjectContext) {
        didSaveModel = true
    }
}
