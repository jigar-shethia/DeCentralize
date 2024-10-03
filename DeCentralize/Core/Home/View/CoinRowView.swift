//
//  CoinRowView.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 24/09/24.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    let showHoldingColumn :Bool
    var body: some View {
        
        HStack {
            letftColoumn
            Spacer()
            if showHoldingColumn {
                centerColunm
            }
            leftcolumn
        }
        .font(.subheadline)
            
    }
}
extension CoinRowView{
    private var letftColoumn: some View {
        HStack{
            Text("\(coin.rank)")
                .font(.caption)
                .frame(minWidth:0)
                .foregroundColor(Color.theme.secondaryText)
                .padding(.leading,10)
            Circle()
                .frame(width: 30, height: 30)
            Text("\(coin.symbol.uppercased())")
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .padding(.leading, 6)
        }
    }
    
    private var centerColunm: some View {
        VStack(alignment: .trailing, content: {
            Text("\(coin.currentHoldingValue.asCurrencyWith2Decimals())")
            Text("\(coin.currentHoldings?.asNumberString() ?? "")")
        })
        .foregroundColor(Color.theme.accent)
    }
    
    private var leftcolumn: some View {
        VStack(alignment: .trailing, content: {
            Text("\(coin.currentPrice.asCurrencyWith2Decimals())")
                .bold()
                .foregroundColor(Color.theme.accent)
            Text("\(coin.priceChangePercentage24H?.asPercentageString() ?? "" )%")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                )
        })
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

#Preview {
    CoinRowView(coin: MockCoin.instance.coin, showHoldingColumn: true).previewLayout(.sizeThatFits)
    
}
