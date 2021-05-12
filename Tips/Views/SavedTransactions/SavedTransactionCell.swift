//
//  SavedTransactionCell.swift
//  Tips
//
//  Created by David Para on 5/11/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import CoreData
import SwiftUI

struct SavedTransactionCell: View {
    @Environment(\.colorScheme) var colorScheme
    
    var transaction: Transaction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.name ?? "N/A")
                    .font(.title2)
                    .padding([.leading, .top, .trailing])
                Divider()
                HStack {
                    Text(transaction.dateAdded ?? Date(), style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding([.leading])
                    Spacer()
                    Text(transaction.total ?? "$0.00")
                        .padding([.trailing])
                }
                .padding([.top, .bottom])
            }
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 0.5))
        .cornerRadius(8)
        .shadow(color: colorScheme == .dark ? .clear : .gray, radius: 5, x: 10, y: 10)
    }
}

struct SavedTransactionCell_Previews: PreviewProvider {
    static var previews: some View {
        let context = NSPersistentContainer.tips.viewContext
        let transaction = Transaction(context: context)
        transaction.name = "This is a test transaction"
        transaction.dateAdded = Date()
        transaction.amount = "$20.00"
        transaction.tip = 5
        transaction.total = "$25.00"
        
        return SavedTransactionCell(transaction: transaction)
            .environment(\.managedObjectContext, context)
    }
}
