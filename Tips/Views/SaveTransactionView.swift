//
//  SaveTransactionView.swift
//  Tips
//
//  Created by David Para on 5/10/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import SwiftUI

struct SaveTransactionView: View {
    @State var transactionName: String = ""
    
    @Binding var show: Bool
    
    var saveTransactionViewModel: SaveTransactionViewModel
    
    var body: some View {
        VStack {
            Text("File away as")
                .padding([.top], 16)
                .font(.body.weight(.semibold))
            TextField("Transaction name", text: $transactionName)
                .multilineTextAlignment(.center)
                .padding([.bottom], 8)
                .padding([.leading, .trailing], 16)
                .font(.footnote)
            Divider()
            HStack {
                Spacer()
                Button(
                    action: {
                        transactionName = ""
                        show.toggle()
                    },
                    label: { Text("Cancel").foregroundColor(.red) }
                )
                Spacer()
                Divider().frame(height: 32)
                Spacer()
                Button(
                    action: {
                        saveTransactionViewModel.saveTransaction(named: transactionName)
                    },
                    label: { Text("Save") }
                )
                Spacer()
            }.padding([.bottom], 8)
        }
        .background(Color.init(.white))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 0.25)
        )
        .shadow(color: .gray, radius: 5, x: 5, y: 5)
    }
}


struct SaveTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        let transactionStore = TransactionStore(inMemory: false,
                                                with: .tips,
                                                contextType: .main)
        let transaction = Transaction()
        let viewModel = SaveTransactionViewModel(store: transactionStore, transaction: transaction)
        return SaveTransactionView(show: .constant(true),
                            saveTransactionViewModel: viewModel)
    }
}
