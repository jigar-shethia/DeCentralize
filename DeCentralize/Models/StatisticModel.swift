//
//  StatistucModel.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 19/10/24.
//

import Foundation
struct StatisticModel: Identifiable{
    
    var id = UUID()
    var title: String
    var value: String
    var percentageChange:Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
    
}
