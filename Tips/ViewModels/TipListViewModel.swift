//
//  TipListViewModel.swift
//  Tips
//
//  Created by David Para on 6/28/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

class TipListViewModel: ObservableObject {
    @Published var tipOptions: [TipViewModel] = [
        TipViewModel(tipPercentage: 15),
        TipViewModel(tipPercentage: 18),
        TipViewModel(tipPercentage: 20)
    ]
}
