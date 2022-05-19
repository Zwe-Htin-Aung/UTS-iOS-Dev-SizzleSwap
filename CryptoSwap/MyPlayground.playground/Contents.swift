import UIKit
import Combine

//constants
//let defaultSession = URLSession(configuration: .default)
//var dataTask: URLSessionDataTask?
//var errorMessage = ""
//var cryptoCoins: [CryptoCoin] = []
//
//typealias JSONDictionary = [String: Any]
//typealias QueryResult = ([CryptoCoin]?, String) -> Void


//let chosenCurrency = "aud"
//let maxDisplayedCoins = 100
//let order = "market_cap_desc"
//let pageCount = 1
//
//var components = URLComponents()
//
//components.scheme = "https"
//components.host = "api.coingecko.com"
//components.path = "/api/v3/coins/markets"
//
//let currency = URLQueryItem(name: "vs_currency", value: chosenCurrency)
//let orderedList = URLQueryItem(name: "order", value: order)
//let maxDisplayed = URLQueryItem(name: "per_page", value: String(maxDisplayedCoins))
//let page = URLQueryItem(name: "page", value: String(pageCount))
//let sparkline = URLQueryItem(name: "sparkline", value: "false")
//
//components.queryItems = [currency, orderedList, maxDisplayed, page, sparkline]
//
//print(components.url)


//
//struct queryViewModel {
//    
//    let defaultSession = URLSession(configuration: .default)
//    var dataTask: URLSessionDataTask?
//    var errorMessage = ""
//    var cryptoCoins: [CryptoCoin] = []
//
//    typealias JSONDictionary = [String: Any]
//    typealias QueryResult = ([CryptoCoin]?, String) -> Void
//    
//    func getAllCoins(search: String, completion: @escaping QueryResult) {
//        
//        dataTask?.cancel()
//        
//        guard let url = components.url else {
//            return
//        }
//        
//        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
//            defer {
//                self?.dataTask = nil
//            }
//            
//            if let error = error {
//                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
//            } else if
//                let data = data,
//                let response = response as? HTTPURLResponse,
//                response.statusCode == 200 {
//                
//                self?.formatAndDisplayData(data)
//                
//                DispatchQueue.main.async {
//                    completion(self?.cryptoCoins, self?.errorMessage ?? "")
//                }
//            }
//            dataTask?.resume()
//        }
//    }
//
//    private func formatAndDisplayData(_ data: Data) {
//        var res: JSONDictionary?
//        
//        //delete the previous array
//        cryptoCoins.removeAll()
//        
//        //try to deserealize the json response
//        do {
//            res = try JSONSerialization.jsonObject(with: data, options: [] as? JSONDictionary)
//        }
//        catch let parsingError as NSError {
//            errorMessage += "JSON Serializing error: \(parsingError.localizedDescription) \n"
//            return
//        }
//        
//        guard let coinArray = response! as? [Any] else {
//            errorMessage += "Dictionary doesn't have any results key \n"
//            return
//        }
//        
//        //loop through and create the coin array
//        var index = 0
//        
//        for coins in coinArray {
//            if let coins = coins as? JSONDictionary,
//               let id = coins["id"] as? String,
//               let name = coins["name"] as? String,
//               let symbol = coins["symbol"] as? String,
//               let image = coins["image"] as? URL,
//               let currentPrice = coins["current_price"] as? Int,
//               let marketCap = coins["market_cap"] as? Int,
//               let marketCap24HourChange = ["market_cap_change_24h"] as? Int
//        }
//        
//        let currentCoin = CryptoCoin(id: id, name: name, symbol: symbol, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCap24HourChange: marketCap24HourChange)
//        
//        cryptoCoins.append(currentCoin)
//    } else {
//        errorMessage += "Problem parsing array response\n"
//    }
//}
//


//func getSearchResults(searchTerm: String, completion: @escaping QueryResult) {
//  // 1
//  dataTask?.cancel()
//
//  // 2
//  if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
//    urlComponents.query = "media=music&entity=song&term=\(searchTerm)"
//
//    // 3
//    guard let url = urlComponents.url else {
//      return
//    }
//
//    // 4
//    dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
//      defer {
//        self?.dataTask = nil
//      }
//
//      // 5
//      if let error = error {
//        self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
//      } else if
//        let data = data,
//        let response = response as? HTTPURLResponse,
//        response.statusCode == 200 {
//
//        self?.updateSearchResults(data)
//
//        // 6
//        DispatchQueue.main.async {
//          completion(self?.tracks, self?.errorMessage ?? "")
//        }
//      }
//    }
//
//    // 7
//    dataTask?.resume()
//  }
//}

//
//private func updateSearchResults(_ data: Data) {
//    var response: JSONDictionary?
//    tracks.removeAll()
//
//    do {
//        response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
//    } catch let parseError as NSError {
//        errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
//        return
//    }
//
//    guard let array = response!["results"] as? [Any] else {
//        errorMessage += "Dictionary does not contain results key\n"
//        return
//    }
//
//    var index = 0
//
//    for trackDictionary in array {
//        if let trackDictionary = trackDictionary as? JSONDictionary,
//           let previewURLString = trackDictionary["previewUrl"] as? String,
//           let previewURL = URL(string: previewURLString),
//           let name = trackDictionary["trackName"] as? String,
//           let artist = trackDictionary["artistName"] as? String {
//            tracks.append(Track(name: name, artist: artist, previewURL: previewURL, index: index))
//            index += 1
//        } else {
//            errorMessage += "Problem parsing trackDictionary\n"
//        }
//    }
//}


//var currentUrl = apiUrl()
//
//
//class CryptoCoin2: Decodable, Identifiable, ObservableObject {
//
//    var id: String
//    var name: String
//    var symbol: String
//    var image: URL
//    var currentPrice: Int
//    var marketCap: Int
//    var marketCap24HourChange: Int
//
//
//    init(id: String,
//         name: String,
//         symbol: String,
//         image: URL,
//         currentPrice: Int,
//         marketCap: Int,
//         marketCap24HourChange: Int ){
//
//        self.id = id
//        self.name = name
//        self.symbol = symbol
//        self.image = image
//        self.currentPrice = currentPrice
//        self.marketCap = marketCap
//        self.marketCap24HourChange = marketCap24HourChange
//
//    }
//}
//
//
//
//func getTopCoins(){
//    var cryptoList = [CryptoCoin2]()
//    print("printing current URL \(currentUrl.url!)")
//    URLSession.shared.dataTask(with: currentUrl.url!) {(data, response, error) in
//        do {
//            if let coinData = data {
//                // 3.
//                let decodedData = try
//                JSONDecoder().decode([CryptoCoin2].self, from: coinData)
//                DispatchQueue.main.async {
//                    print("trying to print decoded data \(decodedData)")
//                    cryptoList = decodedData
//                }
//            } else {
//                print("No data")
//            }
//        } catch {
//            print("Error caught, decoding error")
//        }
//    }.resume()
//}
//
//getTopCoins()



