//
//  ContentView.swift
//  Tips
//
//  Created by David Para on 5/24/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var totalViewModel: TotalViewModel
    @ObservedObject var tipListViewModel = TipListViewModel()
    
    @State private var showEditTipPercentage = false
    @State private var selectedTipPercentage = 18.0
    
    var currencyFormatter = NumberFormatter.makeCurrencyFormatter(using: .current)
    
    var body: some View {
        NavigationView {
            List {
                TotalCellView(total: totalViewModel.amount,
                              totalViewModel: totalViewModel,
                              currencyFormatter: currencyFormatter)
                HStack {
                    TipPercentageCellView(tipListViewModel: tipListViewModel,
                                          selectedTipPercentage: $selectedTipPercentage)
                    Button(action: {
                            self.showEditTipPercentage = true
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.gray)
                    }
                }
                CalculateTotalButton(totalViewModel: totalViewModel,
                                     selectedTipPercentage: selectedTipPercentage,
                                     currencyFormatter: currencyFormatter)
            }.navigationBarTitle("Tips")
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                    UITableView.appearance().tableFooterView = UIView()
            }
        }
        .sheet(isPresented: self.$showEditTipPercentage, content: {
            EditTipPercentagesView(isPresented: self.$showEditTipPercentage,
                                   tipListViewModel: self.tipListViewModel)
        })
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let numberFormatter = NumberFormatter.makeCurrencyFormatter(using: .current)
        let totalViewModel = TotalViewModel(amount: "", currencyFormatter: numberFormatter)
        return ContentView(totalViewModel: totalViewModel)
    }
}
#endif
