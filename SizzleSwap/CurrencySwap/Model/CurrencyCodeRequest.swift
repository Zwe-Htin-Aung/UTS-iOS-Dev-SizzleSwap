//
//  File.swift
//  SizzleSwap
//
//  Created by Zwe Htin Aung on 13/5/2022.
//

import Foundation

struct CurrencyCodeRequest {
    
    let apiKey = "XF7tAgubdBbD5VQr0BBCYjfUiJhXyDyV"
    let currencyCodeURL =  "https://api.apilayer.com/exchangerates_data/symbols";
    
    func fetch () {
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: currencyCodeURL)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "apikey")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
              print(String(describing: error))
              return
          }
            decodeJSON(currencyData: data)
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
    
    func decodeJSON (currencyData : Data) {
        let decoder = JSONDecoder()
        do {
            let currencyCodes = try decoder.decode(CurrencyCodes.self , from: currencyData)
            print(currencyCodes.success)
            for (code, currencyName) in currencyCodes.symbols {
                print("Code: \(code) --> Currency: \(currencyName)")
            }
            
        } catch {
            print(error);
        }
    }
}
