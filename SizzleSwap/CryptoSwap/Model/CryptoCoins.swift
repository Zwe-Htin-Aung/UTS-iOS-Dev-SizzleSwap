//
//  CryptoCoins.swift
//  SizzleSwap
//
//  Created by Samuel Polgar on 15/5/2022.
//

import Foundation
class CryptoCoins: Identifiable, ObservableObject {
    
    var id: String
    var name: String
    var symbol: String
    var image: String
    var currentPrice: Int
    var marketCap: Int
    var marketCap24HourChange: Int
    
    
    init(id: String,
         name: String,
         symbol: String,
         image: String,
         currentPrice: Int,
         marketCap: Int,
         marketCap24HourChange: Int ){
        
        self.id = id
        self.name = name
        self.symbol = symbol
        self.image = image
        self.currentPrice = currentPrice
        self.marketCap = marketCap
        self.marketCap24HourChange = marketCap24HourChange
        
    }
}


//{
//    "id": "bitcoin",
//    "symbol": "btc",
//    "name": "Bitcoin",
//    "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
//    "current_price": 43180,
//    "market_cap": 822257714857,
//    "market_cap_rank": 1,
//    "fully_diluted_valuation": 906880791167,
//    "total_volume": 33552237580,
//    "high_24h": 43764,
//    "low_24h": 41369,
//    "price_change_24h": 1198.86,
//    "price_change_percentage_24h": 2.8557,
//    "market_cap_change_24h": 16043483359,
//    "market_cap_change_percentage_24h": 1.98998,
//    "circulating_supply": 19040443,
//    "total_supply": 21000000,
//    "max_supply": 21000000,
//    "ath": 93482,
//    "ath_change_percentage": -53.86829,
//    "ath_date": "2021-11-10T14:24:11.849Z",
//    "atl": 72.61,
//    "atl_change_percentage": 59293.13659,
//    "atl_date": "2013-07-05T00:00:00.000Z",
//    "roi": null,
//    "last_updated": "2022-05-15T11:11:54.333Z"
//  }
