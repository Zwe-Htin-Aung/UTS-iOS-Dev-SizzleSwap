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
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var saveSwapButton: UIButton!
    var dropDownFrom = DropDown()
    var dropDownTo = DropDown()
    var conversion : CurrencyConversion = CurrencyConversionRequest().emptyConversion;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        toAmountLabel.isUserInteractionEnabled = false
        saveSwapButton.isUserInteractionEnabled = false
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
        if fieldsAreValid() {
            let from = dropDownLabelFrom.text!
            let to = dropDownLabelTo.text!
            let amount = Float(fromAmountLabel.text ?? "0.0") ?? 0.0
            conversion = CurrencyConversionRequest().fetchConversion(from: from, to: to, amount: amount)
            toAmountLabel.text = String(conversion.result)
        }
        if conversion.success {
            feedbackLabel.text = "Successful Swap!"
            feedbackLabel.textColor = UIColor.green
        }
    }

    let conversionArray = [CurrencyConversion]()
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        if conversion.success {
            UserDefaults.standard.set(conversionArray, forKey: "converted")
            
        }
    }
    
    func fieldsAreValid () -> Bool {
        let amountPattern = #"^[\d]+\.?[\d]{0,2}?$"#
        let currencyCodePattern = #"^[\S]{3}$"#
        if fromAmountLabel.text?.range(of: amountPattern, options: .regularExpression) == nil {
            setAlert(item: dropDownLabelFrom, error: false)
            setAlert(item: dropDownLabelTo, error: false)
            setAlertTextField(item: fromAmountLabel, error: true, message: "Please Enter a Valid Amount")
            return false
        }
        if dropDownLabelFrom.text?.range(of: currencyCodePattern, options: .regularExpression) == nil {
            setAlert(item: dropDownLabelTo, error: false)
            setAlertTextField(item: fromAmountLabel, error: false, message: "")
            setAlert(item: dropDownLabelFrom, error: true)
            return false
        }
        if dropDownLabelTo.text?.range(of: currencyCodePattern, options: .regularExpression) == nil {
            setAlert(item: dropDownLabelFrom, error: false)
            setAlertTextField(item: fromAmountLabel, error: false, message: "")
            setAlert(item: dropDownLabelTo, error: true)
            return false
        }
        setAlertTextField(item: fromAmountLabel, error: false, message: "")
        setAlert(item: dropDownLabelFrom, error: false)
        setAlert(item: dropDownLabelTo, error: false)
        return true
    }
    
    func setAlert(item : UILabel, error: Bool) {
        if error {
            item.layer.borderWidth = 5
            item.layer.borderColor = UIColor.red.cgColor
            feedbackLabel.text = "Please Select Valid Currencies"
        } else {
            item.layer.borderWidth = 0
            feedbackLabel.text = ""
        }
    }
    
    func setAlertTextField(item : UITextField, error: Bool, message: String) {
        if error {
            item.layer.borderWidth = 5
            item.layer.borderColor = UIColor.red.cgColor
            item.text = ""
            feedbackLabel.text = message
        } else {
            item.layer.borderWidth = 0
            feedbackLabel.text = ""
        }
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
