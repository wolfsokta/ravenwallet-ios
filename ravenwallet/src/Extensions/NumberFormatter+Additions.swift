//
//  NumberFormatter+Additions.swift
//  ravenwallet
//
//  Created by Adrian Corscadden on 2017-05-21.
//  Copyright © 2018 Ravenwallet Team. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static func formattedString(amount: Satoshis, rate: Rate?, minimumFractionDigits: Int?, maxDigits: Int) -> String {
        let displayAmount = Amount(amount: amount.rawValue, rate: rate ?? Rate.empty, maxDigits: maxDigits, currency: Currencies.rvn)
        var formatter: NumberFormatter
        var output = ""
        if let rate = rate {
            formatter = NumberFormatter()
            if let minimumFractionDigits = minimumFractionDigits {
                formatter.minimumFractionDigits = minimumFractionDigits
            }
            formatter.locale = rate.locale
            formatter.numberStyle = .currency
            let value = (Double(amount.rawValue)/Double(C.satoshis))*rate.rate
            output = formatter.string(from: value as NSNumber) ?? "error"
        } else {
            formatter = displayAmount.rvnFormat
            if let minimumFractionDigits = minimumFractionDigits {
                formatter.minimumFractionDigits = minimumFractionDigits
            }
            let bits = Bits(satoshis: amount)
            output = formatter.string(from: bits.rawValue as NSNumber) ?? "error"
        }
        return output
    }
    
    static func formattedString(value: Double, currencySymbol: String? = nil, minimumFractionDigits: Int?, maxDigits: Int) -> String {
        var formatter: NumberFormatter
        var output = ""
        formatter = NumberFormatter()
        if let minimumFractionDigits = minimumFractionDigits {
            formatter.minimumFractionDigits = minimumFractionDigits
        }
        if currencySymbol != nil {
            formatter.currencySymbol = currencySymbol
        }
        output = formatter.string(from: value as NSNumber) ?? "error"
        return output
    }
}
