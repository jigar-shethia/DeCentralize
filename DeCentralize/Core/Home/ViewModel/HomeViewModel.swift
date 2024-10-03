//
//  HomeViewModel.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 28/09/24.
//

import Foundation


class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            self.allCoins.append(MockCoin.instance.coin)
            self.allCoins.append(MockCoin.instance.coin)
            self.allCoins.append(MockCoin.instance.coin)
            self.portfolioCoins.append(MockCoin.instance.coin)
        }
    }
}
