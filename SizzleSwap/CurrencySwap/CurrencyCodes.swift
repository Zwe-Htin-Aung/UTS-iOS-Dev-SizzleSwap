//
//  File.swift
//  SizzleSwap
//
//  Created by Zwe Htin Aung on 13/5/2022.
//

import Foundation

struct CurrencyCodes : Decodable {
    var success : Bool
    var symbols : [String : String]
}
