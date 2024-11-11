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
    
    
    //    Convert a Double to a String with K, M, Bn, Tr abbreviations.
    //    Convert 12 to 12.00
    //    Convert 1234 to 1.23K
    //    Convert 123456 to 123.45K
    //    Convert 12345678 to 12.34M
    //    Convert 1234567890 to 1.23Bn
    //    Convert 123456789012 to 123.45Bn
    //    Convert 12345678901234 to 12.34Tr
    
        func formattedWithAbbreviations () -> String {
            let num = abs (Double(self))
            let sign = (self < 0) ? "_" : ""
            
            switch num {
            case 1_000_000_000_000...:
                let formatted = num / 1_000_000_000_000
                let stringFormatted = formatted.asNumberString()
                return "\(sign)\(stringFormatted) Tr"
            case 1_000_000_000...:
                let formatted = num / 1_000_000_000
                let stringFormatted = formatted.asNumberString()
                return "\(sign)\(stringFormatted)Bn"
            case 1_000_000...:
                let formatted = num / 1_000_000
                let stringFormatted = formatted.asNumberString()
                return "\(sign)\(stringFormatted)M"
            case 1_000...:
                let formatted = num / 1_000
                let stringFormatted = formatted.asNumberString()
                return "\(sign)\(stringFormatted)K"
            case
                0...:
                return self.asNumberString()
            default:
                return "\(sign)\(self)"
            }
        }
}
