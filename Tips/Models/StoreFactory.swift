//
//  StoreFactory.swift
//  Tips
//
//  Created by David Para on 5/11/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import CoreData.NSPersistentContainer
import Foundation
import SwiftUI

protocol Store {
    associatedtype T: NSManagedObject
    
    var persistentContainer: NSPersistentContainer { get set }
    
    init()
    init(persistentContainer: NSPersistentContainer,
         inMemory: Bool)
    
    func get(byID id: UUID, context: NSManagedObjectContext) -> T?
    func save(_ model: T, context: NSManagedObjectContext)
    func delete(at offsets: IndexSet,
                in models: FetchedResults<T>,
                context: NSManagedObjectContext)
}

extension Store {
    func delete(at offsets: IndexSet,
                in models: FetchedResults<T>,
                context: NSManagedObjectContext) {
        for index in offsets {
            let model = models[index]
            context.delete(model)
        }
        
        do {
            try context.save()
        } catch let error {
            Log.error(message: "Error deleting \(T.self): \(error)")
        }
    }
}

class StoreFactory {
    enum StoryType {
        case transaction, transactionMock
    }
    
    func make<T: Store>(_ type: StoryType) -> T {
        switch type {
        case .transaction:
            return T(persistentContainer: .tips, inMemory: false)
        case .transactionMock:
            return T()
        }
    }
}
