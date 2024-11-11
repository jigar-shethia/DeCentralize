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
    @Published var searchText: String = ""
    @Published var statistics:[StatisticModel] = []
    

    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancelables = Set<AnyCancellable>()
    
    init(){
        addSubscriber()
    }
    func addSubscriber(){
    
       
        $searchText
        // Get all coin data from this publisher
            .combineLatest(coinDataService.$allCoin)
            .debounce(for: .seconds(0.5), scheduler:DispatchQueue.main)
        // Filtering for search text
            .map(filterCoin)
            .sink {[weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancelables)
        
        
        marketDataService.$marketData
            .map (mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancelables)
        
    }
    
    func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
        var stats : [StatisticModel] = []
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap = StatisticModel(title:"Market Cap" , value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title:"24h Volume" , value: data.volume)
        let btcDominance = StatisticModel(title:"BTC Dominance" , value: data.btcDominance)
        let portfolio = StatisticModel(title:"Portfolio Value" , value: "$0", percentageChange: 0)
        
        stats.append(contentsOf:[
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        return stats
    }
    
    func filterCoin(text:String, coins:[CoinModel])  -> [CoinModel] {
        guard !text.isEmpty else{
            return coins
        }
        let lowercaseText = text.lowercased()
        
        let filterCoins = coins.filter{ (coin) in
            return coin.name.lowercased().contains(lowercaseText) ||
            coin.symbol.lowercased().contains(lowercaseText) ||
            coin.id.lowercased().contains(lowercaseText)
        }
        return filterCoins
    }
}
