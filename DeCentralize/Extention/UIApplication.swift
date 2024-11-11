//
//  UIApplication.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 14/10/24.
//

import Foundation
import SwiftUI
 
extension UIApplication{
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
