//
//  CoinCardView.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 29/11/24.
//

import SwiftUI

struct CoinCardView: View {
    let coin:CoinModel
    
    var body: some View {
        VStack{
            CoinImageView(coinModel: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
            
        }
    }
}

#Preview {
    CoinCardView(coin: MockCoin.instance.coin)
}
