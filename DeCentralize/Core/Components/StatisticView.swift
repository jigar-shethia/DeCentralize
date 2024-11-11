//
//  StatisticView.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 19/10/24.
//

import SwiftUI

struct StatisticView: View {
    var statistic: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text(statistic.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(statistic.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
           
                HStack{
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(
                            Angle(degrees: (statistic.percentageChange ?? 0) >= 0 ? 0:180))
                    Text(statistic.percentageChange?.asPercentageString() ?? "")
                        .font(.caption)
                        .bold()
                }.foregroundColor((statistic.percentageChange ?? 0) >= 0 ? Color.theme.green:Color.theme.red)
                    .opacity((statistic.percentageChange == nil) ? 0:1)
            
        }
    }
}

#Preview {
    Group {
        HStack{
            StatisticView(statistic: MockCoin.instance.statistic1)
            StatisticView(statistic: MockCoin.instance.statistic2)
            StatisticView(statistic: MockCoin.instance.statistic3)
        }
     
    }
    
}
