//
//  CoinImageViewModel.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 07/10/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel:ObservableObject {
    
    @Published var coinImage: UIImage? = nil
    @Published var isLoading:Bool = true
    
    var coinModel: CoinModel
    var imageService : CoinImageService
    private var cancelables = Set<AnyCancellable>()
    
    init(coinModel: CoinModel) {
        self.coinModel = coinModel
        self.imageService = CoinImageService(coinModel: coinModel)
        addSubcriber()
    }
    
    func addSubcriber(){
        imageService.$coinImage
            .sink { [weak self] (_) in
                self?.isLoading = false
        } receiveValue: { [weak self] (retrunedImage) in
            self?.coinImage = retrunedImage
        }
        .store(in: &cancelables)

    }
     
}
