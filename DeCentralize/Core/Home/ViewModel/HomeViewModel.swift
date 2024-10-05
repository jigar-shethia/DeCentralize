//
//  HomeViewModel.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 28/09/24.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let coinDataService = CoinDataService()
    private var cancelables = Set<AnyCancellable>()
    
    init(){
        addSubscriber()
    }
    func addSubscriber(){
        coinDataService.$allCoin
            .sink {[weak self] (returndedCoin) in
                self?.allCoins = returndedCoin
            }
            .store(in: &cancelables)
    }
}
