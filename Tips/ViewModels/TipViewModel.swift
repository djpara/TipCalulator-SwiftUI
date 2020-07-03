//
//  TipViewModel.swift
//  Tips
//
//  Created by David Para on 6/4/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import Foundation

class TipViewModel: ObservableObject {
    @Published var tipPercentage: Double
    
    init(tipPercentage: Double) {
        self.tipPercentage = tipPercentage
    }
    
    func amount(for total: Double) -> Double {
        return total * (tipPercentage)
    }
}
