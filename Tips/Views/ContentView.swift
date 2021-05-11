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
    @ObservedObject var loadAdMonitor = LoadAdMonitor(bannerView: GoogleAdView())
    
    @State private var showEditTipPercentage = false
    @State private var showTipGuide = false
    @State private var showMenuPopover = false
    @State private var showAdvancedView = false
    @State private var showSaveTransactionPopup = false
    
    @State var transactionName: String = ""
    
    var currencyFormatter = NumberFormatter.makeCurrencyFormatter(using: .current)
    private let popupWidth = UIScreen.main.bounds.width/2
    private let transactionStore: TransactionStore
    
    init(amountViewModel: AmountViewModel, storeFactory: StoreFactory = StoreFactory()) {
        self.amountViewModel = amountViewModel
        self.transactionStore = storeFactory.make(.transaction, inMemory: true, context: .main)
    }
    
    var body: some View {
        let billAmoutView = BillAmountView(amountViewModel: amountViewModel)
        let calculationCellView = CalculationsCellView(amountViewModel: amountViewModel)
        let tipPercentageSegmentView = TipPercentageSegmentView(amountViewModel: amountViewModel)
        let calculateTotalButton = CalculateTotalButton(amountViewModel: amountViewModel)
        return VStack {
            NavigationView {
                GeometryReader { geometryWithSafeArea in
                    GeometryReader { geometry in
                        ScrollView {
                            LazyVStack {
                                billAmoutView.padding([.leading, .trailing])
                                calculationCellView.padding([.leading, .trailing])
                                tipPercentageSegmentView.padding([.leading, .trailing])
                                calculateTotalButton.padding([.leading, .trailing])
                            }.navigationBarTitle("Tips")
                            .toolbar {
                                Menu(
                                    content: {
                                        Button(
                                            action: { showTipGuide.toggle() },
                                            label: { Label("Tip Guide", systemImage: "map") }
                                        )
                                        Button(
                                            action: { showEditTipPercentage.toggle() },
                                            label: { Label("Edit Tip Percentages", systemImage: "pencil") }
                                        )
                                        Button(
                                            action: { showSaveTransactionPopup.toggle() },
                                            label: { Label("Save Transaction", systemImage: "square.and.arrow.down") }
                                        )
                                    },
                                    label: {
                                        Image(systemName: "line.horizontal.3")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 24, height: 24) }
                                ).frame(width: 44, height: 44)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            }.padding(.top, geometryWithSafeArea.safeAreaInsets.top)
                            .padding(.bottom, geometryWithSafeArea.safeAreaInsets.bottom)
                            .padding(.leading, geometryWithSafeArea.safeAreaInsets.leading)
                            .padding(.trailing, geometryWithSafeArea.safeAreaInsets.trailing)
                        } .buttonStyle(PlainButtonStyle())
                    }.edgesIgnoringSafeArea(.all)
                }
            }.navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: self.$showEditTipPercentage, content: {
                EditTipPercentagesView(isPresented: self.$showEditTipPercentage)
            })
            .sheet(isPresented: self.$showTipGuide, content: {
                TipGuideView(isPresented: self.$showTipGuide,
                             amountViewModel: amountViewModel)
            })
            .popup(isPresented: showSaveTransactionPopup) {
                let viewModel = SaveTransactionViewModel(amountViewModel: amountViewModel,
                                                         transactionStore: transactionStore)
                SaveTransactionView(show: $showSaveTransactionPopup,
                                    saveTransactionViewModel: viewModel)
                    .frame(width: 250)
            }
            loadAdMonitor.bannerView.frame(height: 60)
        }.onAppear {
            UITableView.appearance().tableFooterView = UIView()
            self.loadAdMonitor.startAdRefreshTimer()
        }.onDisappear {
            self.loadAdMonitor.stopAdRefreshTimer()
        }.onChange(of: self.amountViewModel.tipPercentage) { value in
            amountViewModel.calculate()
        }.onChange(of: self.amountViewModel.originalAmount) { value in
            amountViewModel.calculate()
        }
    }
}


class SaveTransactionViewModel: ObservableObject {
    private(set) var transaction: Transaction
    private let transactionStore: TransactionStore
    
    init(amountViewModel: AmountViewModel, transactionStore: TransactionStore) {
        self.transactionStore = transactionStore
        self.transaction = Transaction(name: "", from: amountViewModel, in: transactionStore.context!)
    }
    
    func saveTransaction(named name: String) {
        transaction.name = name
        transactionStore.save(transaction)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let amountViewModel = AmountViewModel(originalAmount: "$20.00",
                                              currencyFormatter: .makeCurrencyFormatter(using: .current))
        return ForEach(ColorScheme.allCases,
                       id: \.self,
                       content: ContentView(amountViewModel: amountViewModel)
                        .preferredColorScheme)
    }
}
#endif
