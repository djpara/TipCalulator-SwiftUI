//
//  Log.swift
//  Tips
//
//  Created by David Para on 5/9/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import Foundation

struct Log {
    static func debug(message: String,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line) {
        #if DEBUG
        print("⚠️ DEBUG [\(file.split(separator: "/").last ?? "")] - \(function) - #\(line): \(message)")
        #endif
    }
    
    static func error(message: String,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line) {
        #if DEBUG
        print("⛔️ ERROR [\(file.split(separator: "/").last ?? ""))] - \(function) - #\(line): \(message)")
        #endif
    }
}
