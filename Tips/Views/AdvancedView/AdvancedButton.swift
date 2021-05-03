//
//  AdvancedButton.swift
//  Tips
//
//  Created by David Para on 8/26/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

struct AdvancedButton: View {
    private var destination: AdvancedView
    
    init(destination: AdvancedView) {
        self.destination = destination
        
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        ZStack {
            NavigationLink(destination: destination) { EmptyView() }
            Text("Advanced").foregroundColor(.blue)
        }
    }
}
