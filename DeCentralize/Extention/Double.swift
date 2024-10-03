//
//  Double.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 25/09/24.
//

import Foundation




extension Double {
    
    /// Convert a Doulbe value to 2-6 decimal places
    /// ```
    /// Convert 123.56 to $123.56
    /// Convert 12.2356 to $12.2356
    /// Convert 12.235623 to $12.235623
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter =  NumberFormatter()
        formatter.usesGroupingSeparator =  true
        formatter.locale = .current
        formatter.numberStyle = .currency
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    /// Convert a Doulbe value to 2-6 decimal places
    /// ```
    /// Convert 123.56 to "$123.56"
    /// Convert 12.2356 to "$12.2356"
    /// Convert 12.235623 to "$12.235623"
    /// ```
    ///
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    func asPercentageString() -> String {
        return asNumberString() + "%"
    }
}
