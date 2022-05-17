//
//  CryptoCoinViewModel.swift
//  SizzleSwap
//
//  Created by Samuel Polgar on 15/5/2022.
//

import Foundation
import SwiftUI

class CryptoCoinViewModel: ObservableObject {
    var baseUrl = "https://api.coingecko.com/api/v3"
    var topCoinsUrl = "/coins/markets?vs_currency=aud&order=market_cap_desc&per_page=100&page=1&sparkline=false"
    
    

    @Published var cryptoList = [CryptoCoins]()
    
    func getTopCoins(){
        //call coingeckoAPI
        //
        let baseAndEndURL = baseUrl+topCoinsUrl
        if let url = URL(string: baseAndEndURL) {
            URLSession.shared.dataTask(with: url) {
                
            }
        }
    }
}
    
    
//if let url = URL(string: "http://www.json-generator.com/api/json/get/cfpeTpOFrC?indent=2") {
//   URLSession.shared.dataTask(with: url) { data, response, error in
//if let data = data {
//let jsonDecoder = JSONDecoder()
//do {
//let parsedJSON = try jsonDecoder.decode(Entry.self, from: data)
//for image in parsedJSON.images {
//print(image.value.imageURL)
//print(image.value.uploaderName)
//            }
//        } catch {
//print(error)
//        }
//       }
//   }.resume()
//}
