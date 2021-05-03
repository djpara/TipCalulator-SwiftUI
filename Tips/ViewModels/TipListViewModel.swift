//
//  TipListViewModel.swift
//  Tips
//
//  Created by David Para on 6/28/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

class TipListViewModel: ObservableObject {
    enum Option: String {
        case first, second, third
    }
    
    var userDefaults = UserDefaults.standard
    
    init() {
        let first = userDefaults.double(forKey: Option.first.rawValue)
        let second = userDefaults.double(forKey: Option.second.rawValue)
        let third = userDefaults.double(forKey: Option.third.rawValue)
        
        let firstOption = first == 0 ? 15 : first
        let secondOption = second == 0 ? 18 : second
        let thirdOption = third == 0 ? 20 : third
        
        tipOptions = [
            TipViewModel(tipPercentage: firstOption),
            TipViewModel(tipPercentage: secondOption),
            TipViewModel(tipPercentage: thirdOption)
        ]
    }
    
    @Published var tipOptions: [TipViewModel] = [
        TipViewModel(tipPercentage: 15),
        TipViewModel(tipPercentage: 18),
        TipViewModel(tipPercentage: 20)
    ]
}
