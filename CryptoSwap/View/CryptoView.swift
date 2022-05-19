////
////  CryptoView.swift
////  SizzleSwap
////
////  Created by Samuel Polgar on 17/5/2022.
////
//import Foundation
//import SwiftUI
//
//struct CryptoView: View {
//    @ObservedObject var model = CryptoCoinViewModel()
//    
//    @State var id = ""
//    
//    var body: some View {
//        NavigationView {
//            List(model.cryptoList) { item in
//                VStack(alignment: .leading) {
//                    Text("Id: \(item.id)")
//                        .font(.title)
//                }
//            } .navigationTitle("hello")
//        }
//    }
//    
//    init() {
//        print("here")
//        model.getTopCoins()
//    }
//}
//
//var child = UIHostingController(rootView: CryptoView())
//
//
//struct CryptoView_Previews: PreviewProvider {
//    static var previews: some View {
//        CryptoView()
//    }
//}
