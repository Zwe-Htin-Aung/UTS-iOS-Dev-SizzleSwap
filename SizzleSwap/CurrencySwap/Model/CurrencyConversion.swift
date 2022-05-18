//
//  CurrencyConversion.swift
//  SizzleSwap
//
//  Created by Zwe Htin Aung on 18/5/2022.
//

import Foundation

struct CurrencyConversion : Decodable {
    var date : String
    var info : Info
    var query : Query
    var result : Float
    var success : Bool
}

struct Info : Decodable {
    var rate : Float
    var timestamp : Int
}

struct Query : Decodable {
    var amount : Float
    var from : String
    var to : String
}
