//
//  EditTipPercentagesView.swift
//  Tips
//
//  Created by David Para on 6/28/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct EditTipPercentagesView: View {
    @Binding var isPresented: Bool
    
    var tipListViewModel: TipListViewModel
    var tipOptions: [TipViewModel] = []
    
    init(isPresented: Binding<Bool>, tipListViewModel: TipListViewModel) {
        _isPresented = isPresented
        self.tipListViewModel = tipListViewModel
        
        tipOptions = tipListViewModel.tipOptions.map { TipViewModel(tipPercentage: $0.tipPercentage) }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(0..<tipListViewModel.tipOptions.count) {
                    EditTipPercentagesCell(tipOptions: self.tipListViewModel.tipOptions,
                                           newTipOptions: self.tipOptions,
                                           atIndex: $0)
                }.padding([.top, .bottom], 8)
            }.navigationBarTitle("Edit Tip Percentages", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    UIApplication.closeAllKeyboards(.shared)
                    self.tipListViewModel.tipOptions = self.tipOptions
                    self.isPresented = false
                }, label: {
                    Text("Save")
                }))
                .onAppear {
                    UITableView.appearance().tableFooterView = UIView()
            }
        }
    }
}

#if DEBUG
struct EditTipPercentagesView_Previews: PreviewProvider {
    static var previews: some View {
        let tipListViewModel = TipListViewModel()
        return EditTipPercentagesView(isPresented: .constant(false), tipListViewModel: tipListViewModel)
    }
}
#endif
