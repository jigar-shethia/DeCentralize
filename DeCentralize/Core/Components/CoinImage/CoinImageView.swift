//
//  CoinImageView.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 07/10/24.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm : CoinImageViewModel
    var coinModel: CoinModel
    
    init(coinModel: CoinModel) {
       _vm = StateObject(wrappedValue: CoinImageViewModel(coinModel: coinModel))
        self.coinModel = coinModel
    }
    
    var body: some View {
        if let image = vm.coinImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }else if vm.isLoading {
            ProgressView()
        }else{
            Image(systemName:"questionmark")
                .foregroundColor(Color.theme.secondaryText)
        }
    }
}

#Preview {
    CoinImageView(coinModel: MockCoin.instance.coin)
}
