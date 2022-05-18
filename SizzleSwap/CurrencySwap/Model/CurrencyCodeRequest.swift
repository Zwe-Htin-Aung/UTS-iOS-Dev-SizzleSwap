//
//  File.swift
//  SizzleSwap
//
//  Created by Zwe Htin Aung on 13/5/2022.
//

import Foundation

struct CurrencyCodeRequest {
    
    let apiKey = "XF7tAgubdBbD5VQr0BBCYjfUiJhXyDyV"
    let currencyCodeURL =  "https://api.apilayer.com/exchangerates_data/symbols"
    // var result : CurrencyCodes
    
    func fetch() -> CurrencyCodes {
        let semaphore = DispatchSemaphore (value: 0)
        var result : CurrencyCodes = CurrencyCodes(success: false, symbols: [:])
        var request = URLRequest(url: URL(string: currencyCodeURL)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "apikey")
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            if let safeData = data {
                result = decodeJSON(currencyData: safeData)
                semaphore.signal()
            } else {
                print(String(describing: error))
                return
            }
        }
        task.resume()
        semaphore.wait()
        return result
    }
    
    func decodeJSON(currencyData : Data) -> CurrencyCodes {
        let decoder = JSONDecoder()
        do {
            let currencyCodes = try decoder.decode(CurrencyCodes.self , from: currencyData)
            print(currencyCodes.success)
            for (code, currencyName) in currencyCodes.symbols {
                print("Code: \(code) --> Currency: \(currencyName)")
            }
            return currencyCodes
        } catch {
            print(error)
            return CurrencyCodes(success: false, symbols: [:])
        }
    }
}
