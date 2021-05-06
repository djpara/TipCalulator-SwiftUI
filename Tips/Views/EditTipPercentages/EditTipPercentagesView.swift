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
    
    var userDefaults = UserDefaults.standard
    
    var tipListViewModel: TipListViewModel
    var tipOptions: [TipViewModel] = []
    
    private var descriptionTextWidth: CGFloat {
        UIScreen.main.bounds.width/2
    }
    
    private var labels = ["Good", "Very good", "Best"]
    
    init(isPresented: Binding<Bool>, tipListViewModel: TipListViewModel) {
        _isPresented = isPresented
        self.tipListViewModel = tipListViewModel
        
        tipOptions = tipListViewModel.tipOptions.map { TipViewModel(tipPercentage: $0.tipPercentage) }
    }
    
    private func saveTipOptionsToUserDefaults() {
        for (counter, tipOption) in tipOptions.enumerated() {
            var option: TipListViewModel.Option
            
            switch counter {
            case 1:
                option = .second
            case 2:
                option = .third
            default:
                option = .first
            }
            
            userDefaults.set(tipOption.tipPercentage, forKey: option.rawValue)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("How much do you tip for quality of service?")
                    .frame(width: descriptionTextWidth)
                    .font(.caption)
                    .padding([.top], 16)
                    .multilineTextAlignment(.center)
                List {
                    ForEach(0..<tipListViewModel.tipOptions.count) {
                        EditTipPercentagesCell(label: labels[$0],
                                               tipOptions: self.tipListViewModel.tipOptions,
                                               newTipOptions: self.tipOptions,
                                               atIndex: $0)
                    }.padding([.top, .bottom], 8)
                }.navigationBarTitle("Tips 💸", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
                        UIApplication.closeAllKeyboards(.shared)
                        self.isPresented = false
                    }, label: {
                        Image(systemName: "xmark")
                    }),
                    trailing: Button(action: {
                        UIApplication.closeAllKeyboards(.shared)
                        self.tipListViewModel.tipOptions = self.tipOptions
                        self.isPresented = false
                        self.saveTipOptionsToUserDefaults()
                    }, label: {
                        Text("Save")
                    }))
                .onAppear {
                    UITableView.appearance().tableFooterView = UIView()
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
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
