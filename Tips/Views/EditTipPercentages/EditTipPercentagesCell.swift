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
    var label: String
    var oldTipOption: String
    var newTipOptions = [Tip]()
    
    @State private var newTipOption: String
    
    init(label: String, tipOptions: [Tip], newTipOptions: [Tip], atIndex index: Int) {
        self.label = label
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
        
        return HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(label).font(.footnote).foregroundColor(.gray)
                HStack {
                    TextField(oldTipOption, text: bindingProxy)
                        .keyboardType(.numberPad)
                    Text("%").padding([.trailing], 16)
                }
            }.padding([.leading], 8)
        }
    }
}

#if DEBUG
struct EditTipPercentagesCell_Previews: PreviewProvider {
    static var previews: some View {
        let tipOptions = TipConfig().tipOptions
        return EditTipPercentagesCell(label: "Ok", tipOptions: tipOptions, newTipOptions: tipOptions, atIndex: 0)
    }
}
#endif
