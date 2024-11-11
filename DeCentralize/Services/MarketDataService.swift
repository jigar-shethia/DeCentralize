//
//  MarketDataService.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 04/11/24.
//

import Foundation
import  Combine

class MarketDataService {
    
    @Published var marketData:MarketDataModel? = nil
    var marketDataSubcription: AnyCancellable?
    
    init(){
        getData()
    }
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        marketDataSubcription = NetworkingManger.download(url: url)
            .eraseToAnyPublisher()
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink  (receiveCompletion: NetworkingManger.completionBlock,
                    receiveValue: { [weak self](returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubcription?.cancel()
                
            })
    }
}
