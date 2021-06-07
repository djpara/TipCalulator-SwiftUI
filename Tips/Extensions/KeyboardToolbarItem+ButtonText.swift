//
//  KeyboardToolbarItem+ButtonText.swift
//  Tips
//
//  Created by David Para on 5/19/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import UIKit

extension KeyboardToolbarItem {
    static let withDoneLabel = KeyboardToolbarItem(text: "Done", color: .accentColor, isFixed: .trailing) {
        UIApplication.closeAllKeyboards(.shared)
    }
}
