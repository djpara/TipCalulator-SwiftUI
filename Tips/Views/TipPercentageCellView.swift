//
//  TipPercentageCellView.swift
//  Tips
//
//  Created by David Para on 6/3/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct TipPercentageCellView: View {
    @ObservedObject var tipListViewModel: TipListViewModel
    @Binding var selectedTipPercentage: Double
    
    func getTipPercentage(for tipViewModel: TipViewModel) -> String {
        return String(format: "%.f%@", tipViewModel.tipPercentage, "%")
    }
    
    var body: some View {
        Picker("", selection: $selectedTipPercentage) {
            ForEach(tipListViewModel.tipOptions, id: \.tipPercentage) { tipViewModel in
                Text(self.getTipPercentage(for: tipViewModel))
            }
        }.pickerStyle(SegmentedPickerStyle())
    }
}

#if DEBUG
struct TipPercentageCellView_Previews: PreviewProvider {
    static var previews: some View {
        TipPercentageCellView(tipListViewModel: TipListViewModel(), selectedTipPercentage: .constant(15))
    }
}
#endif
