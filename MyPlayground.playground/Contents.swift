import UIKit

extension NumberFormatter {
    static func makeCurrencyFormatter(using locale: Locale) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = locale
        return formatter
    }
}

extension Double {
    var nsNumberValue: NSNumber {
        return NSNumber(value: self)
    }
}

extension String {
    func convertForCurrency(using currencyFormatter: NumberFormatter) -> String? {
        let stringToDouble = currencyFormatter.number(from: self)?.doubleValue ?? Double(self)
        if let double = stringToDouble {
            let value = double / 100
            return currencyFormatter.string(for: double)
        }
        
        return nil
        
        
        
//        if let stringToNumber = currencyFormatter.number(from: self),
//            let stringFormattedForCurrency = currencyFormatter.string(from: stringToNumber / NSNumber(100)) {
//            return "\(stringFormattedForCurrency)"
//        } else if let stringToDouble = Double(self), let stringFormattedForCurrency = currencyFormatter.string(from: (stringToDouble / 100.0).nsNumberValue) {
//            return stringFormattedForCurrency
//        } else {
//            return nil
//        }
    }
}

let currencyFormatter = NumberFormatter.makeCurrencyFormatter(using: .current)

let doubleFromString = Double("6")
let stringFormattedForCurrency = currencyFormatter.string(from: doubleFromString!.nsNumberValue)

let stringWithDollarSign = "$6"
let number = currencyFormatter.number(from: stringWithDollarSign)

"6.12".convertForCurrency(using: currencyFormatter)
"$6.00".convertForCurrency(using: currencyFormatter)
