//
//  HometatisticView.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 21/10/24.
//

import SwiftUI

struct HomeStatisticView: View {
    @EnvironmentObject  var vm: HomeViewModel
    @Binding var showportfolio:Bool
    
    var body: some View {
        HStack{
            ForEach(vm.statistics){stat in
                StatisticView(statistic: stat)
                    .frame(width: UIScreen.main.bounds.width/3)
            }
        }.frame(width: UIScreen.main.bounds.width,alignment: showportfolio ? .trailing: .leading)
    }
}

#Preview {
    HomeStatisticView(showportfolio: .constant(false))
        .environmentObject(MockCoin.instance.homeVM)
}
