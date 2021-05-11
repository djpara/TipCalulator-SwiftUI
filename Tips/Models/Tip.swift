//
//  Tip.swift
//  Tips
//
//  Created by David Para on 6/4/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import Foundation

class Tip: ObservableObject {
    @Published var tipPercentage: Double
    
    init(tipPercentage: Double) {
        self.tipPercentage = tipPercentage
    }
    
    func amount(for total: Double) -> Double {
        return total * (tipPercentage)
    }
}
