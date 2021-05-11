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
    
    var tipConfig: TipConfig
    var tipOptions: [Tip] = []
    
    private var descriptionTextWidth: CGFloat {
        UIScreen.main.bounds.width/2
    }
    
    private var labels = ["Good", "Very good", "Best"]
    
    init(isPresented: Binding<Bool>, tipConfig: TipConfig = .init()) {
        _isPresented = isPresented
        self.tipConfig = tipConfig
        
        tipOptions = tipConfig.tipOptions.map { Tip(tipPercentage: $0.tipPercentage) }
    }
    
    private func saveTipOptionsToUserDefaults() {
        for (counter, tipOption) in tipOptions.enumerated() {
            var option: TipConfig.Option
            
            switch counter {
            case 0:
                option = .first
            case 1:
                option = .second
            case 2:
                option = .third
            default:
                return
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
                    ForEach(0..<tipConfig.tipOptions.count - 1) {
                        EditTipPercentagesCell(label: labels[$0],
                                               tipOptions: self.tipConfig.tipOptions,
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
                        self.tipConfig.tipOptions = self.tipOptions
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
        return EditTipPercentagesView(isPresented: .constant(false))
    }
}
#endif
