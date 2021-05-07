//
//  ListSeparatorStyle.swift
//  Tips
//
//  Created by David Para on 5/7/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import SwiftUI

struct ListSeparatorStyle: ViewModifier {
    let style: UITableViewCell.SeparatorStyle
    
    func body(content: Content) -> some View {
        content
            .onAppear() {
                UITableView.appearance().separatorStyle = style
            }
    }
}

extension View {
    func listSeparatorStyle(style: UITableViewCell.SeparatorStyle) -> some View {
        ModifiedContent(content: self, modifier: ListSeparatorStyle(style: style))
    }
}
