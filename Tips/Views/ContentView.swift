//
//  ContentView.swift
//  Tips
//
//  Created by David Para on 5/24/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var amountViewModel: AmountViewModel
    @ObservedObject var tipListViewModel: TipListViewModel
    @ObservedObject var loadAdMonitor = LoadAdMonitor(bannerView: GoogleAdView())
    
    @State private var showEditTipPercentage = false
    @State private var showTipGuide = false
    @State private var showMenuPopover = false
    @State private var showAdvancedView = false
    
    @State var selectedTipPercentage = 0.0
    @State var customTipPercentage: Double?
    
    var currencyFormatter = NumberFormatter.makeCurrencyFormatter(using: .current)
    
    init(amountViewModel: AmountViewModel, tipListViewModel: TipListViewModel) {
        self.amountViewModel = amountViewModel
        self.tipListViewModel = tipListViewModel
    }
    
    var body: some View {
        let billAmoutView = BillAmountView(total: amountViewModel.originalAmount,
                                           amountViewModel: amountViewModel,
                                           currencyFormatter: currencyFormatter)
        let calculationCellView = CalculationsCellView(amountViewModel: amountViewModel,
                                                       currencyFormatter: currencyFormatter)
        let tipPercentageSegmentView = TipPercentageSegmentView(tipListViewModel: tipListViewModel,
                                                                selectedTipPercentage: $selectedTipPercentage,
                                                                customTipPercentage: $customTipPercentage)
        let calculateTotalButton = CalculateTotalButton(selectedTipPercentage: $selectedTipPercentage,
                                                        customTipPercentage: $customTipPercentage,
                                                        amountViewModel: amountViewModel,
                                                        currencyFormatter: currencyFormatter)
        return VStack {
            NavigationView {
                List {
                    billAmoutView
                    calculationCellView
                    tipPercentageSegmentView
                    calculateTotalButton
                }.navigationBarTitle("Tips")
                .toolbar {
                    Menu(
                        content: {
                            Button(
                                action: { showTipGuide.toggle() },
                                label: { Text("Tip Guide")}
                            )
                            Button(
                                action: { showEditTipPercentage.toggle() },
                                label: { Text("Edit Tip Percentages") }
                            )
                        },
                        label: {
                            Image(systemName: "line.horizontal.3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24) }
                    ).frame(width: 44, height: 44)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                .buttonStyle(PlainButtonStyle())
            }.navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: self.$showEditTipPercentage, content: {
                EditTipPercentagesView(isPresented: self.$showEditTipPercentage,
                                       tipListViewModel: self.tipListViewModel)
            })
            .sheet(isPresented: self.$showTipGuide, content: {
                TipGuideView(isPresented: self.$showTipGuide,
                             selectedTipPercentage: self.$selectedTipPercentage,
                             customTipPercentage: self.$customTipPercentage)
            })
            loadAdMonitor.bannerView.frame(height: 60)
        }.onAppear {
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().tableFooterView = UIView()
            self.loadAdMonitor.startAdRefreshTimer()
        }.onDisappear {
            self.loadAdMonitor.stopAdRefreshTimer()
        }.onChange(of: customTipPercentage, perform: { value in
            calculateTotalButton.calculate()
        })
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let amountViewModel = AmountViewModel(totalAmount: "$20.00",
                                              currencyFormatter: .makeCurrencyFormatter(using: .current))
        return ForEach(ColorScheme.allCases, id: \.self, content: ContentView(amountViewModel: amountViewModel, tipListViewModel: TipListViewModel()).preferredColorScheme)
    }
}
#endif
