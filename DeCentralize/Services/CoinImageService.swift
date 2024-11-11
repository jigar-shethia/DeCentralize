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
    private var imageSubscription: AnyCancellable?
    private var coinModel: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coinModel: CoinModel) {
        self.coinModel = coinModel
        self.imageName = coinModel.id
        getCoinImage()
    }
    func getCoinImage(){
        if let image = fileManager.getImage(imageName: imageName, folderName: folderName){
            coinImage = image
            print("Retrieved image from file Manager")
        }else{
            print("Downloading the coin")
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coinModel.image) else { return }
        
        imageSubscription = NetworkingManger.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManger.completionBlock, receiveValue: { [weak self] (returnedImage) in
                guard
                    let self = self,
                    let downloadedImage = returnedImage
                else { return }
                
//                self.coinImage = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })

    }
    
    
}
