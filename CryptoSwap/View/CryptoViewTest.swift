//
//  CryptoViewTest.swift
//  SizzleSwap
//
//  Created by Samuel Polgar on 19/5/2022.
//

import Foundation
import SwiftUI

var coingecko = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=AUD&per_page=100&page=1&sparkline=false&price_change_percentage=24"

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


struct CryptoView: View {
    
    @State var cryptocoins: [CryptoCoin] = []
    
    var body: some View {
        NavigationView {
            List(cryptocoins) { coin in
                HStack {
                    Text(coin.name)
                        .font(.headline)
                } .padding(7)
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

struct CryptoView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoView()
    }
}
