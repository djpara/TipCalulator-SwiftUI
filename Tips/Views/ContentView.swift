//
//  ContentView.swift
//  Tips
//
//  Created by David Para on 5/24/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var amountViewModel: AmountViewModel
    @ObservedObject var tipListViewModel: TipListViewModel
    @ObservedObject var loadAdMonitor = LoadAdMonitor(bannerView: GoogleAdView())
    
    @State private var showEditTipPercentage = false
    @State private var showAdvancedView = false
    
    @State var selectedTipPercentage = 0.0

    var currencyFormatter = NumberFormatter.makeCurrencyFormatter(using: .current)
    
    init(amountViewModel: AmountViewModel, tipListViewModel: TipListViewModel) {
        self.amountViewModel = amountViewModel
        self.tipListViewModel = tipListViewModel
    }
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    BillAmountView(total: amountViewModel.originalAmount,
                                   amountViewModel: amountViewModel,
                                   currencyFormatter: currencyFormatter)
                    CalculationsCellView(amountViewModel: amountViewModel,
                                         currencyFormatter: currencyFormatter)
                    TipPercentageCell(tipListViewModel: tipListViewModel,
                                      selectedTipPercentage: $selectedTipPercentage,
                                      showEditTipPercentage: $showEditTipPercentage)
                    CalculateTotalButton(selectedTipPercentage: $selectedTipPercentage,
                                         amountViewModel: amountViewModel,
                                         currencyFormatter: currencyFormatter)
                }.navigationBarTitle("Tips")
                .buttonStyle(PlainButtonStyle())
            }.navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: self.$showEditTipPercentage, content: {
                EditTipPercentagesView(isPresented: self.$showEditTipPercentage,
                                       tipListViewModel: self.tipListViewModel)
            })
            loadAdMonitor.bannerView.frame(height: 60)
        }.onAppear {
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().tableFooterView = UIView()
            self.loadAdMonitor.startAdRefreshTimer()
        }.onDisappear {
            self.loadAdMonitor.stopAdRefreshTimer()
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let amountViewModel = AmountViewModel(totalAmount: "$20.00",
                                              currencyFormatter: .makeCurrencyFormatter(using: .current))
        return ContentView(amountViewModel: amountViewModel, tipListViewModel: TipListViewModel())
    }
}
#endif
