//
//  CoinModel.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 11/09/24.
//

import Foundation

// CoinGekko Api URL Coin/Market
/*
 URL:
 
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=2&sparkline=true&price_change_percentage=24'
 
 Json Repose
 
 {
 "id": "liquid-staked-ethereum",
 "symbol": "lseth",
 "name": "Liquid Staked ETH",
 "image": "https://coin-images.coingecko.com/coins/images/28848/large/LsETH-receipt-token-circle.png?1696527824",
 "current_price": 2725.55,
 "market_cap": 231287149,
 "market_cap_rank": 251,
 "fully_diluted_valuation": 231287149,
 "total_volume": 15557.27,
 "high_24h": 2768.41,
 "low_24h": 2701.64,
 "price_change_24h": 15.7,
 "price_change_percentage_24h": 0.5793,
 "market_cap_change_24h": 1202012,
 "market_cap_change_percentage_24h": 0.52242,
 "circulating_supply": 84858.7656721695,
 "total_supply": 84858.7656721695,
 "max_supply": null,
 "ath": 4264.83,
 "ath_change_percentage": -36.09029,
 "ath_date": "2024-03-12T00:25:57.696Z",
 "atl": 1384.61,
 "atl_change_percentage": 96.85285,
 "atl_date": "2023-03-10T11:26:12.210Z",
 "roi": null,
 "last_updated": "2024-09-22T20:11:25.068Z",
 "sparkline_in_7d": {
 "price": [
 2484.8714850420965,
 2484.476539088118,
 2481.4217819078326,
 2457.119416500905,
 ]
 }
 }
 */

import Foundation

struct CoinModel: Codable, Identifiable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
        
    }
    
    func updateHolding(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency:priceChangePercentage24HInCurrency, currentHoldings: currentHoldings)
    }
    
    var currentHoldingValue: Double{
        return (currentHoldings ?? 0) * currentPrice
    }
    var rank: Int{
        return Int(marketCapRank ?? 0)
    }
}




struct SparklineIn7D: Codable {
    let price: [Double]?
}


