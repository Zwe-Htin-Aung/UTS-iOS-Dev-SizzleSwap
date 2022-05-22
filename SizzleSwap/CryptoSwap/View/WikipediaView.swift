//
//  WikipediaView.swift
//  SizzleSwap
//
//  Created by Samuel Polgar on 20/5/2022.
//https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=ethereum

import SwiftUI
import Foundation

struct WikipediaView: View {
    
    @State var isExpanded = false
    @State var subviewHeight : CGFloat = 0
    @State var title = ""
    @State var extract = ""
    @State var coinName = ""
    var wikipediaSearchName = ""
    
    let searchTerms = [
        "Bitcoin": "Bitcoin",
        "Ethereum": "Ethereum",
        "Tether": "Tether (cryptocurrency)",
        "USD Coin": "USD_Coin",
        "BNB": "Binance",
        "XRP": "Ripple (payment protocol)",
        "Binance USD": "Binance",
        "Cardano": "Cardano (blockchain platform)",
        "Solana": "Solana (blockchain platform)",
        "Doge": ""
    ]
    
    init(currentCoinName: String){
        print("here in inittt!!!")
        if currentCoinName != "" {
            print("working??? \(searchTerms[currentCoinName]!)")
            self.wikipediaSearchName = searchTerms[currentCoinName]!
        } else {
            self.wikipediaSearchName = "Bitcoin"
        }
        print("self.coin name is \(self.wikipediaSearchName)")
    }
    
    var body: some View {
        VStack {
            VStack {
                Text(extract)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.subheadline)
            }
        }
        .background(GeometryReader {
            Color.clear.preference(key: ViewHeightKey.self,
                                   value: $0.frame(in: .local).size.height)
        })
        .onPreferenceChange(ViewHeightKey.self) { subviewHeight = $0 }
        .frame(height: isExpanded ? subviewHeight : 100, alignment: .top)
        .padding()
        .clipped()
        .frame(maxWidth: .infinity)
        .transition(.move(edge: .bottom))
        .background(Color.white.cornerRadius(10.0))
        .onTapGesture {
            withAnimation(.easeOut(duration: 1.0)) {
                isExpanded.toggle()
            }
        }
        .onAppear {
            print("when does this occur?")
            WikipediaApiCall().getWikiSummary(wikipediaSearchName: self.wikipediaSearchName) { (title, extract) in
                self.title = title
                self.extract = extract
            }
        }
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}



//model
//struct WikipediaView_Previews: PreviewProvider {
//    static var previews: some View {
//        WikipediaView()
//    }
//}

// MARK: - WikipediaResponse
struct WikipediaResponse: Codable {
    let batchcomplete: String?
    let query: WikiQuery
}

// MARK: - Query
struct WikiQuery: Codable {
    let normalized: [Normalized]
    let pages: [String:WikipediaPage]
}

// MARK: - Normalized
struct Normalized: Codable {
    let from, to: String
}

// MARK: - The41754003
struct WikipediaPage: Codable {
    let title: String
    let extract: String
}



//viewmodel
class WikipediaApiCall {
    func getWikiSummary(wikipediaSearchName: String, completion:@escaping (_ title: String, _ extract: String) -> ()) {
        
        guard let urlHardcoded = URL(string: "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=ethereum") else {
            fatalError("Invalid URL")
        }
        
        
        let lowerwikipediaSearchName = wikipediaSearchName.lowercased()
        let escapedString = lowerwikipediaSearchName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        print(escapedString!)
        
        let baseUrl = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles="
        let urlDynamic = baseUrl+escapedString!

        guard let url = URL(string: urlDynamic) else {
            fatalError("Invalid URL")
        }
        
        print("urlDynamic \(url)")
        print("urlHardcoded\(urlHardcoded)")
        
        print("sending coinName to the URL \(lowerwikipediaSearchName)")
        
//        var components = URLComponents(string: "https://en.wikipedia.org/w/api.php")!
//
//        let queryItems = [
//            URLQueryItem(name: "format", value: "json"),
//            URLQueryItem(name: "action", value: "query"),
//            URLQueryItem(name: "prop", value: "extracts"),
//            URLQueryItem(name: "exintro", value: ""),
//            URLQueryItem(name: "explaintext", value: ""),
//            URLQueryItem(name: "redirects", value: "1"),
//            URLQueryItem(name: "titles", value: wikipediaSearchName)
//        ]
//
//        components.queryItems = queryItems
//
//        print("url together \(components.url!)")
//        guard let url = URL(string: components.url!.absoluteString) else {
//            print("invalid url")
//            return
//        }
//
//        print(components.url)
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            print("here or there")
            
            let result = try? JSONDecoder().decode(WikipediaResponse.self, from: data)
            if let result = result {
                //get the page id
                let pages = result.query.pages

                let pageKey = pages.compactMap {$0.key}
                let pageKeyString = String(pageKey[0])

                //parse object to get extract, then set to state var
                var pageObj: WikipediaPage
                pageObj = pages[pageKeyString]!


                //set statevar
                let pageExtract = pageObj.extract
                let pageTitle = pageObj.title
                print("page extract: \(pageExtract)")

                DispatchQueue.main.async {
                    completion(pageTitle, pageExtract)
                }
                
            }
            
        }.resume()
    }
}
    //}
    //
    //        URLSession.shared.dataTask(with: url) { (data, _, _) in
    //
    //            let result = try? JSONDecoder().decode(WikipediaResponse.self, from: data!)
    //
    //            print("printing result \(result)")
    //
    //            if let result = result {
    //
    ////                get the page id
    //                let pages = result.query.pages
    //
    //                let pageKey = pages.compactMap {$0.key}
    //                let pageKeyString = String(pageKey[0])
    //
    //                //parse object to get extract, then set to state var
    //                var pageObj: WikipediaPage
    //                pageObj = pages[pageKeyString]!
    //
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
    //        }
    //        .resume()
    //    }
    //}
