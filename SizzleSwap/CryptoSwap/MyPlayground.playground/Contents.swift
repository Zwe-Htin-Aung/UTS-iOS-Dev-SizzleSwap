//import UIKit
//
//
////var baseUrl = "https://api.coingecko.com/api/v3"
////var topCoinsUrl = "/coins/markets?vs_currency=aud&order=market_cap_desc&per_page=100&page=1&sparkline=false"
////
////let baseAndEndURL = baseUrl+topCoinsUrl
////print(baseAndEndURL)
//
//
//var wikipediaSearchName = "Tether (cryptocurrency)"
//WikipediaApiCall2().getWikiSummary(wikipediaSearchName: wikipediaSearchName) { (title, extract) in
//    print("title is \(title)")
//    print("extract is \(extract)")
//}
//
//class WikipediaApiCall2 {
//    func getWikiSummary(wikipediaSearchName: String, completion:@escaping (_ title: String, _ extract: String) -> ()) {
//        print("sending coinName to the URL \(wikipediaSearchName)")
//
////        var components = URLComponents(string: "https://en.wikipedia.org/w/api.php")!
////
////        let queryItems = [
////            URLQueryItem(name: "format", value: "json"),
////            URLQueryItem(name: "action", value: "query"),
////            URLQueryItem(name: "prop", value: "extracts"),
////            URLQueryItem(name: "exintro", value: "explaintext"),
////            URLQueryItem(name: "redirects", value: "1"),
////            URLQueryItem(name: "titles", value: wikipediaSearchName)
////        ]
////
////        components.queryItems = queryItems
////
////        print("url together \(components.url!)")
////
////        let url: URL
////        url = components.url!
//        
//        
//        
//        let wikipedia = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro=explaintext&redirects=1&titles=Tether%20(cryptocurrency)"
//
//        
//        guard let url = URL(string: wikipedia) else { return }
//        
//        URLSession.shared.dataTask(with: url) { (data, _, _) in
//
////            guard let data = data, error == nil else {
////                print("line 144")
////                return
////            }
//
//            
//            let result = try! JSONDecoder().decode(WikipediaResponse.self, from: data!)
//
//                //                get the page id
//                let pages = result.query.pages
//
//                let pageKey = pages.compactMap {$0.key}
//                let pageKeyString = String(pageKey[0])
//
//                //parse object to get extract, then set to state var
//                var pageObj: WikipediaPage
//                pageObj = pages[pageKeyString]!
//                print("printing extract\(pageObj.extract)")
//
//                //set statevar
//                let pageExtract = pageObj.extract
//                let pageTitle = pageObj.title
//                print("page extract: \(pageExtract)")
//
//                DispatchQueue.main.async {
//                    completion(pageTitle, pageExtract)
//                }
//            }
//        .resume()
//    }
//}
////
////
////    func getCryptoCoins(completion:@escaping ([CryptoCoin]) -> ()) {
////        guard let url = URL(string: wikipedia) else { return }
////        URLSession.shared.dataTask(with: url) {
////            (data, _, _) in
////            let cryptocoins = try! JSONDecoder().decode([CryptoCoin].self, from: data!)
////            print(cryptocoins)
////
////            DispatchQueue.main.async {
////                completion(cryptocoins)
////            }
////        }
////        .resume()
////    }
////
////getCryptoCoins { (cryptocoins) in
////    print(cryptocoins)
////    print("hello")
////}
//
//
//let result = "{"batchcomplete":"","warnings":{"extracts":{"*":"HTML may be malformed and/or unbalanced and may omit inline images. Use at your own risk. Known problems are listed at https://www.mediawiki.org/wiki/Special:MyLanguage/Extension:TextExtracts#Caveats."}},"query":{"pages":{"55977923":{"pageid":55977923,"ns":0,"title":"Tether (cryptocurrency)","extract":"<p><b>Tether</b> (often called by its symbol <b>USDT</b>) is a stablecoin cryptocurrency that is hosted on the Ethereum and Bitcoin blockchains, among others. Its tokens are issued by the Hong Kong company Tether Limited, which in turn is controlled by the owners of Bitfinex. Tether is called a stablecoin because it was originally designed to always be worth US$1.00, maintaining $1.00 in reserves for each tether issued.</p><p>While, according to its 2021 settlement with the New York Attorney General Letitia James, \"Tether represents to users that any holder of tethers can redeem them from Tether the company at the rate of one tether for one U.S. dollar\", Tether Limited as of 2017 stated that owners of tethers have no contractual right, other legal claims, or guarantee that tethers will or can be redeemed or exchanged for dollars. On 30 April 2019, Tether Limited's lawyer claimed that each tether was backed by $0.74 in cash"}}}}"
//
