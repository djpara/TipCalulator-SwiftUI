//
//  UIApplication+Extensions.swift
//  Tips
//
//  Created by David Para on 7/2/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import UIKit

extension UIApplication {
    static func closeAllKeyboards(_ application: UIApplication) {
        application.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
