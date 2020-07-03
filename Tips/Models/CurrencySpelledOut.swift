//
//  CurrencySpelledOut.swift
//  Tips
//
//  Created by David Para on 6/14/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import Foundation

struct CurrencySpelledOut {
    @SpellOutCurrency var value: String
    
    init(value: String) {
        self.value = value
    }
}
