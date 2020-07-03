//
//  EditTipPercentagesCell.swift
//  Tips
//
//  Created by David Para on 6/28/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct EditTipPercentagesCell: View {
    var index: Int
    var oldTipOption: String
    var newTipOptions = [TipViewModel]()
    
    @State private var newTipOption: String
    
    init(tipOptions: [TipViewModel], newTipOptions: [TipViewModel], atIndex index: Int) {
        self.index = index
        self.newTipOptions = newTipOptions
        
        let formattedTipPercentage = String(format: "%.f",
                                            tipOptions[index].tipPercentage)
        oldTipOption = formattedTipPercentage
        _newTipOption = State<String>(initialValue: formattedTipPercentage)
    }
    
    var body: some View {
        let bindingProxy = Binding<String>(
            get: { return self.newTipOption },
            set: {
                self.newTipOption = $0
                self.newTipOptions[self.index].tipPercentage = $0.doubleValue ?? 0
        })
        
        return TextField(oldTipOption, text: bindingProxy)
            .keyboardType(.numberPad)
    }
}

#if DEBUG
struct EditTipPercentagesCell_Previews: PreviewProvider {
    static var previews: some View {
        let tipOptions = TipListViewModel().tipOptions
        return EditTipPercentagesCell(tipOptions: tipOptions, newTipOptions: tipOptions, atIndex: 0)
    }
}
#endif
