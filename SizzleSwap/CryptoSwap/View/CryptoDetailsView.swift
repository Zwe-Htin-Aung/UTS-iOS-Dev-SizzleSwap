//
//  CryptoDetailsView.swift
//  SizzleSwap
//
//  Created by Samuel Polgar on 22/5/2022.
//
import Foundation
import SwiftUI

struct CryptoDetailsView: View {
    let currentCoin: CryptoCoin
    
    
    var body: some View {
        NavigationView {
            let imageString = currentCoin.image
            
            
            List{
                VStack(alignment: .leading){
                    HStack {
                        Text(currentCoin.symbol)
                            .font(.headline)
                        Spacer()
                        
                        //image
                        AsyncImage(url: URL(string: imageString)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.red
                        }
                                .frame(width: 25, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .padding(2)
                        .aspectRatio(contentMode: .fit)
                    }
                    VStack(alignment: .leading){
                        let marketCapValue = NumberFormatter.localizedString(from: currentCoin.market_cap as NSNumber, number: .currency)
                        Text("Current Price $:\(currentCoin.current_price)")
                        Text("Market Cap $:\(String(marketCapValue))")
                        Text("24 Hour Change :\(currentCoin.market_cap_change_percentage_24h)%")
                    }
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("Background")
                            .font(.headline)
                        Spacer()
                        Label("", systemImage: "arrow.up.left.and.arrow.down.right")
                            .font(.headline)
                    }
//                    WikipediaView()
                    WikipediaView(currentCoinName: currentCoin.name)
                }
            }
            .navigationBarTitle(currentCoin.name)
        }
    }
}
//
//
//
//
//struct CryptoTestDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let currentCoin = CryptoCoin(id: "btc", name: "Bitcoin", symbol: "BTC", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", current_price: 40000.00, market_cap: 10000000, market_cap_change_percentage_24h: 5.00)
//
//        CryptoDetailsView(currentCoin: currentCoin)
//    }
//}
