//
//  StoreFactory.swift
//  Tips
//
//  Created by David Para on 5/11/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import CoreData.NSPersistentContainer
import Foundation

protocol Store {
    associatedtype T
    
    init(inMemory: Bool, with: NSPersistentContainer, contextType: ManagedObjectContextType)
    func get(byID id: UUID) -> T?
    func save(_ model: T)
}

class StoreFactory {
    enum StoryType {
        case transaction
    }
    
    func make<T: Store>(_ type: StoryType, inMemory: Bool, context: ManagedObjectContextType) -> T {
        switch type {
        case .transaction:
            return T(inMemory: inMemory, with: .tips, contextType: .main)
        }
    }
}
