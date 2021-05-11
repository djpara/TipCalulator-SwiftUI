//
//  CoreData+Persistence.swift
//  Tips
//
//  Created by David Para on 5/9/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import CoreData

enum ManagedObjectContextType {
    case main
    case background
    case custom(NSManagedObjectContext)
}

extension NSPersistentContainer {
    static var tips = NSPersistentContainer(name: "Tips")
}

extension NSManagedObjectContext {
    static func context(for type: ManagedObjectContextType,
                        container: NSPersistentContainer) -> NSManagedObjectContext {
        switch type {
        case .main:
            return container.viewContext
        case .background:
            return container.newBackgroundContext()
        case .custom(let context):
            return context
        }
    }
}
