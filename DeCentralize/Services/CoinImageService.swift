//
//  CoinImagDownlodService.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 07/10/24.
//

import Foundation
import Combine
import SwiftUI
      
class CoinImageService {
    
    @Published var coinImage: UIImage? = nil
    var imageSubscription: AnyCancellable?
    var coinModel: CoinModel
    
    init(coinModel: CoinModel) {
        self.coinModel = coinModel
        getCoinImage()
    }
    
    func getCoinImage() {
        guard let url = URL(string: coinModel.image)else{
            return
        }
        imageSubscription = NetworkingManger.download(url: url)
            .tryMap({(data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManger.completionBlock
                  , receiveValue: { [weak self] (returnedImage) in
                self?.coinImage = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
    
    
}
