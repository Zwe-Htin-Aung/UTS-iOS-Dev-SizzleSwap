//
//  File.swift
//  SizzleSwap
//
//  Created by Zwe Htin Aung on 13/5/2022.
//

import Foundation
import UIKit
import DropDown

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var fromAmountLabel: UITextField!
    @IBOutlet weak var toAmountLabel: UITextField!
    @IBOutlet weak var dropDownViewFrom: UIView!
    @IBOutlet weak var dropDownLabelFrom: UILabel!
    @IBOutlet weak var dropDownViewTo: UIView!
    @IBOutlet weak var dropDownLabelTo: UILabel!
    var dropDownFrom = DropDown()
    var dropDownTo = DropDown()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        toAmountLabel.isUserInteractionEnabled = false
        let codes = getCodes(currencyData: CurrencyCodeRequest().fetch())
        setUpDropDownFrom(dataSource: codes)
        setUpDropDownTo(dataSource: codes)
    }
    
    func setUpDropDownFrom(dataSource : [String]) {
        dropDownFrom.anchorView = dropDownViewFrom
        dropDownFrom.dataSource = dataSource
        dropDownFrom.bottomOffset = CGPoint(x: 0, y:(dropDownFrom.anchorView?.plainView.bounds.height)!)
        dropDownFrom.selectionAction = { [unowned self] (index: Int, item: String) in
            dropDownLabelFrom.text = item
        }
        
    }
    
    func setUpDropDownTo(dataSource : [String]) {
        dropDownTo.anchorView = dropDownViewTo
        dropDownTo.dataSource = dataSource
        dropDownTo.bottomOffset = CGPoint(x: 0, y:(dropDownTo.anchorView?.plainView.bounds.height)!)
        dropDownTo.selectionAction = { [unowned self] (index: Int, item: String) in
            dropDownLabelTo.text = item
        }
        
    }
    
    @IBAction func dropDownFromPressed(_ sender: UIButton) {
        dropDownFrom.show()
    }
    
    @IBAction func dropDownToPressed(_ sender: UIButton) {
        dropDownTo.show()
    }
    
    @IBAction func convertPressed(_ sender: UIButton) {
        
    }
    
    func getCodes(currencyData : CurrencyCodes) -> [String] {
        var codes : [String] = []
        if(currencyData.success) {
            for (code, _) in currencyData.symbols {
                codes.append(code)
            }
        }
        return codes.sorted()
    }
    
}
