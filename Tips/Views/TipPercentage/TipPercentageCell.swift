//
//  TipPercentageCell.swift
//  Tips
//
//  Created by David Para on 8/16/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct TipPercentageCell: View {
    @Binding var selectedTipPercentage: Double
    @Binding var showEditTipPercentage: Bool
    
    var tipListViewModel: TipListViewModel
    var userDefaultsStandard = UserDefaults.standard
    
    init(tipListViewModel: TipListViewModel, selectedTipPercentage: Binding<Double>, showEditTipPercentage: Binding<Bool>) {
        self.tipListViewModel = tipListViewModel
        _selectedTipPercentage = selectedTipPercentage
        _showEditTipPercentage = showEditTipPercentage
    }
    
    var body: some View {
        HStack {
            TipPercentageSegmentView(tipListViewModel: tipListViewModel,
                                  selectedTipPercentage: $selectedTipPercentage)
            Button(action: {
                self.showEditTipPercentage = true
            }) {
                Image(systemName: "gear")
                    .foregroundColor(.gray)
            }
        }
    }
}
