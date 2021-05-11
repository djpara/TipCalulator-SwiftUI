//
//  TipConfig.swift
//  Tips
//
//  Created by David Para on 6/28/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

class TipConfig: ObservableObject {
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
            Tip(tipPercentage: firstOption),
            Tip(tipPercentage: secondOption),
            Tip(tipPercentage: thirdOption),
            Tip(tipPercentage: -1)
        ]
    }
    
    @Published var tipOptions: [Tip] = [
        Tip(tipPercentage: 15),
        Tip(tipPercentage: 18),
        Tip(tipPercentage: 20),
        Tip(tipPercentage: -1)
    ]
}
