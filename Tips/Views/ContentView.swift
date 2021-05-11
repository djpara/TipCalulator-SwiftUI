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
    private var popupWidth = UIScreen.main.bounds.width/2
    
    init(amountViewModel: AmountViewModel) {
        self.amountViewModel = amountViewModel
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
                SaveTransactionView(show: $showSaveTransactionPopup,
                                    saveTransactionViewModel: makeTransactionViewModel())
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
    
    private func makeTransactionViewModel() -> SaveTransactionViewModel {
        let transactionStore = TransactionStore(inMemory: true,
                                                with: .tips,
                                                contextType: .main)
        let transaction = transactionStore.makeTransaction(amount: amountViewModel.originalAmount.doubleValue ?? 0,
                                                           tipPercentage: amountViewModel.tipPercentage,
                                                           tip: amountViewModel.tip,
                                                           total: amountViewModel.totalAmount.doubleValue ?? 0)
        return SaveTransactionViewModel(store: transactionStore,
                                        transaction: transaction)
    }
}


class SaveTransactionViewModel: ObservableObject {
    @Published var transaction: Transaction?
    var store: TransactionStore
    
    init(store: TransactionStore, transaction: Transaction?) {
        self.store = store
        self.transaction = transaction
    }
    
    func saveTransaction(named name: String) {
        guard let transaction = transaction else { return }
        transaction.name = name
        store.save(transaction)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let amountViewModel = AmountViewModel(totalAmount: "$20.00",
                                              currencyFormatter: .makeCurrencyFormatter(using: .current))
        return ForEach(ColorScheme.allCases,
                       id: \.self,
                       content: ContentView(amountViewModel: amountViewModel)
                        .preferredColorScheme)
    }
}
#endif
