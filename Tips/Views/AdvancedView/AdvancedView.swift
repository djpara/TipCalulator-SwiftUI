//
//  AdvancedView.swift
//  Tips
//
//  Created by David Para on 8/26/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct AdvancedView: View {
    @State var total = 0.0
    
    var body: some View {
        VStack {
            HStack {
                Text("Total:").padding()
                Spacer()
            }
            Spacer()
        }
    }
}

struct AdvancedView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedView()
    }
}
