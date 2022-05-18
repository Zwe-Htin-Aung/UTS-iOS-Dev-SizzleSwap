//
//  CurrencyConversionRequest.swift
//  SizzleSwap
//
//  Created by Zwe Htin Aung on 18/5/2022.
//

import Foundation

struct CurrencyConversionRequest {
    
    let apiKey = "XF7tAgubdBbD5VQr0BBCYjfUiJhXyDyV"
    let emptyConversion = CurrencyConversion(date: "", info: Info(rate: 0, timestamp: 0), query: Query(amount: 0, from: "", to: ""), result: 0, success: false)
    
    func fetchConversion(from: String, to: String, amount: Float) -> CurrencyConversion {
        let currencyCodeURL = "https://api.apilayer.com/exchangerates_data/convert?to=\(to)&from=\(from)&amount=\(amount)"
        return requestConversion(url: currencyCodeURL)
    }
    
    func requestConversion(url: String) -> CurrencyConversion {
        let semaphore = DispatchSemaphore (value: 0)
        var result : CurrencyConversion = emptyConversion
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "apikey")
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            if let safeData = data {
                result = decodeJSON(conversionData: safeData)
                semaphore.signal()
            } else {
                print(String(describing: error))
                return
            }
        }
        task.resume()
        semaphore.wait()
        return result    }
    
    func decodeJSON(conversionData : Data) -> CurrencyConversion {
        let decoder = JSONDecoder()
        do {
            let conversion = try decoder.decode(CurrencyConversion.self , from: conversionData)
            return conversion
        } catch {
            print(error)
            return emptyConversion
        }
    }
}
