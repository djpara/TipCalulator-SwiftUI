//
//  Transaction+CoreDataProperties.swift
//  Tips
//
//  Created by David Para on 5/11/21.
//  Copyright © 2021 David Para. All rights reserved.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var tip: Double
    @NSManaged public var tipPercentage: Double
    @NSManaged public var total: String?
    @NSManaged public var dateAdded: Date?

}

extension Transaction : Identifiable {

}
