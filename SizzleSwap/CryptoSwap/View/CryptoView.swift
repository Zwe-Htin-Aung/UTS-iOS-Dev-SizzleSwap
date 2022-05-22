//
//  CryptoView.swift
//  SizzleSwap
//
//  Created by Samuel Polgar on 22/5/2022.
//

import SwiftUI

struct CryptoView: View {
    
    @State var cryptocoins: [CryptoCoin] = []
    
    var body: some View {
        NavigationView {
            List(cryptocoins) { coin in
                NavigationLink(destination: CryptoDetailsView(currentCoin: coin)) {
                    VStack(){
                        HStack (){
                            //add in image
                            let imageString = coin.image
                            let currentValue = NumberFormatter.localizedString(from: coin.current_price as NSNumber, number: .currency)
                            
                            AsyncImage(url: URL(string: imageString)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.red
                            }
                            .frame(width: 25, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .padding(2)
                            
                            Text(coin.name)
                                .font(.headline)
                            
                            Text("\(String(currentValue))")
                                .multilineTextAlignment(.trailing)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                            //
                        } .padding(7)
                    }
                }
            }
            .navigationBarTitle("Crypto Coins")
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear {
                cryptoApiCaller().getCryptoCoins { (cryptocoins) in
                    self.cryptocoins = cryptocoins
                    print("hello")
                }
            }
        }
    }
}



//viewmodel
var coingecko = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=AUD&per_page=10&page=1&sparkline=false&price_change_percentage=24"
var wikipedia = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&explaintext=1&titles=bitcoin"

class cryptoApiCaller {
    func getCryptoCoins(completion:@escaping ([CryptoCoin]) -> ()) {
        guard let url = URL(string: coingecko) else { return }
        URLSession.shared.dataTask(with: url) {
            (data, _, _) in
            let cryptocoins = try! JSONDecoder().decode([CryptoCoin].self, from: data!)
            print(cryptocoins)
            
            DispatchQueue.main.async {
                completion(cryptocoins)
            }
        }
        .resume()
    }
}

//model
import Foundation
import Combine

class CryptoCoin: Codable, Identifiable, ObservableObject {
    
    let id: String
    let name: String
    let symbol: String
    let image: String
    let current_price: Double
    let market_cap: Int
    let market_cap_change_percentage_24h: Double
    
    
    init(id: String,
         name: String,
         symbol: String,
         image: String,
         current_price: Double,
         market_cap: Int,
         market_cap_change_percentage_24h: Double){
        
        self.id = id
        self.name = name
        self.symbol = symbol
        self.image = image
        self.current_price = current_price
        self.market_cap = market_cap
        self.market_cap_change_percentage_24h = market_cap_change_percentage_24h
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case image
        case current_price
        case market_cap
        case market_cap_change_percentage_24h
    }
}
//
//struct CryptoView_Previews: PreviewProvider {
//    static var previews: some View {
//        CryptoView()
//    }
//}
