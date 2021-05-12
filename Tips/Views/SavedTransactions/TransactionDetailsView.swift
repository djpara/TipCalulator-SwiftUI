//
//  TransactionDetailsView.swift
//  Tips
//
//  Created by David Para on 5/12/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import SwiftUI

struct TransactionDetailsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var transaction: Transaction?
    let currencyFormatter: NumberFormatter
    
    init(transaction: Binding<Transaction?>,
         currencyFormatter: NumberFormatter = .makeCurrencyFormatter(using: .current)) {
        _transaction = transaction
        self.currencyFormatter = currencyFormatter
    }
    
    var body: some View {
        let tipPercentage = "\(Int(transaction?.tipPercentage ?? 0))%"
        let tip = (transaction?.tip.stringValue ?? "")
            .convertForCurrency(using: currencyFormatter) ?? ""
        VStack {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(transaction?.name ?? "N/A")
                            .font(.title2)
                        if let moreDetails = transaction?.moreDetails {
                            Text(moreDetails)
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    Text(transaction?.dateAdded ?? Date(), style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding([.leading], 16)
                }
                Divider().padding([.leading, .trailing], -16)
                HTitleLabelView(title: "Bill", label: transaction?.amount ?? "$0.00")
                HTitleLabelView(title: "Tip percentage", label: tipPercentage)
                HTitleLabelView(title: "Tip", label: tip)
                HTitleLabelView(title: "Total", label: transaction?.total ?? "$0.00")
            }.padding([.leading, .top, .trailing])
            Divider()
            Button(
                action: {
                    clear()
                },
                label: { Text("OK") }
            )
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16))
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 0.25)
        )
        .shadow(color: colorScheme == .dark ? .clear : .gray, radius: 8, x: 1, y: 1)
    }
    
    private func clear() {
        transaction = nil
    }
}

struct HTitleLabelView: View {
    var title: String
    var label: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.footnote)
                .foregroundColor(Color.gray)
            Spacer()
            Text(label)
                .font(.callout)
                .padding(8)
        }
    }
}

struct TransactionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let context = TransactionStoreMock().persistentContainer.viewContext
        let transaction = Transaction(context: context)
        transaction.name = "New Transaction"
        transaction.moreDetails = "Here are some more details about this particular transaction. I was able to split the transaction with a friend quite easily. This was good stuff."
        transaction.amount = "$20.00"
        transaction.tipPercentage = 25
        transaction.tip = 5
        transaction.total = "$25.00"
        
        return TransactionDetailsView(transaction: .constant(transaction))
            .environment(\.managedObjectContext, context)
    }
}
