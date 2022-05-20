//
//  CurrencyConversion.swift
//  SizzleSwap
//
//  Created by Zwe Htin Aung on 18/5/2022.
//

import Foundation

struct CurrencyConversion : Codable { // was Decodable
    var date : String
    var info : Info
    var query : Query
    var result : Float
    var success : Bool
}

struct Info : Codable {
    var rate : Float
    var timestamp : Int
}

struct Query : Codable {
    var amount : Float
    var from : String
    var to : String
}
