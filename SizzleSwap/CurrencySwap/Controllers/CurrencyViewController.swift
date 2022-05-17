//
//  File.swift
//  SizzleSwap
//
//  Created by Zwe Htin Aung on 13/5/2022.
//

import Foundation
import UIKit

class CurrencyViewController: UIViewController {
    
    var currencyCodeRequest = CurrencyCodeRequest();

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func convertPressed(_ sender: UIButton) {
        currencyCodeRequest.fetch()
    }
    
}
