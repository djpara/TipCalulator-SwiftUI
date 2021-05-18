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
    private var showShadow: Bool {
        colorScheme == .light
    }
    
    var body: some View {
        let dateBackgroundColor: Color
        let daySince = Calendar(identifier: .gregorian)
            .dateComponents([.day], from: transaction.dateAdded ?? Date(), to: Date()).day ?? 0
        if daySince > 10 {
            dateBackgroundColor = .red
        } else if daySince > 5 {
            dateBackgroundColor = .yellow
        } else {
            dateBackgroundColor = .green
        }
        
        return HStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(transaction.dateAdded ?? Date(), style: .date)
                    .font(.caption)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .rotationEffect(.degrees(-90))
                    .fixedSize()
                    .frame(width: 32)
                Divider()
            }
            .background(dateBackgroundColor)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(transaction.name ?? "N/A")
                    .font(.title2)
                    .padding()
                    .lineLimit(1)
                Divider()
                HStack {
                    Text(transaction.moreDetails ?? "No details")
                        .lineLimit(1)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding([.leading, .trailing])
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
        .if(showShadow) {
            $0.shadow(color: .gray, radius: 5, x: 1, y: 1)
        }
    }
}

#if DEBUG
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
#endif
