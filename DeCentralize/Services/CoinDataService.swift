//
//  CoinDataService.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 04/10/24.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoin: [CoinModel] = []
    var coinSubscription : AnyCancellable?
    init() {
        getCoin()
    }
    func getCoin() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=2&sparkline=true&price_change_percentage=24'")
        else{
            return
        }               
        coinSubscription = NetworkingManger.download(url: url)
            .eraseToAnyPublisher()
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink  (receiveCompletion: NetworkingManger.completionBlock,
                    receiveValue: { [weak self](returnedcoin) in
                self?.allCoin = returnedcoin
                self?.coinSubscription?.cancel()
                
            })
    }
}
