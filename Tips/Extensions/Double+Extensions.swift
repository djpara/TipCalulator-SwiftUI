//
//  Double+Extensions.swift
//  Tips
//
//  Created by David Para on 5/26/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import Foundation

extension Double {
    var nsNumberValue: NSNumber {
        return NSNumber(value: self)
    }
    
    var stringValue: String {
        return String(self)
    }
}
