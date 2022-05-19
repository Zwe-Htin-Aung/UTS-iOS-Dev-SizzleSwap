//
//  CryptoCoinViewModel.swift
//  SizzleSwap
//
//  Created by Samuel Polgar on 15/5/2022.
//
import Foundation
import SwiftUI

class CryptoCoinViewModel: ObservableObject {
    
    var currentUrl = apiUrl()
   
    @Published var cryptoList = [CryptoCoin]()

    func getTopCoins(){
        print("printing current URL \(currentUrl.url!)")
        URLSession.shared.dataTask(with: currentUrl.url!) {(data, response, error) in
            do {
                if let coinData = data {
                    // 3.
                    let decodedData = try
                    JSONDecoder().decode([CryptoCoin].self, from: coinData)
                    DispatchQueue.main.async {
                        print("trying to print decoded data \(decodedData)")
                        self.cryptoList = decodedData
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("Error")
            }
        }.resume()
    }
}
