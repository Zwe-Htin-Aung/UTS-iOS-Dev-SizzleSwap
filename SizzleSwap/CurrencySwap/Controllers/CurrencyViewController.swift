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
    @IBOutlet weak var favouritesButton: UIBarButtonItem!
    var dropDownFrom = DropDown()
    var dropDownTo = DropDown()
    var conversion : CurrencyConversion = CurrencyConversionRequest().emptyConversion;
    var from : String = ""
    var to : String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        toAmountLabel.isUserInteractionEnabled = false
        saveSwapButton.isEnabled = false
        let codes = getCodes(currencyData: CurrencyCodeRequest().fetch())
        setUpDropDownFrom(dataSource: codes)
        setUpDropDownTo(dataSource: codes)
        if from != "" && to != "" {
            dropDownLabelFrom.text = from
            dropDownLabelTo.text = to
        }
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
            feedbackLabel.textColor = UIColor.black
            saveSwapButton.isEnabled = true
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        if conversion.success {
            var conversions = readSavedConversions()
            if checkConversionExist() {
                feedbackLabel.text = "Conversion Already Saved!"
                feedbackLabel.textColor = UIColor.black
            } else {
                conversions.append(conversion)
                UserDefaults.standard.set(try? PropertyListEncoder().encode(conversions), forKey: "conversions")
                feedbackLabel.text = "Successfully Saved!"
                feedbackLabel.textColor = UIColor.black
            }
        }
    }
    
    func checkConversionExist() -> Bool {
        let conversions = readSavedConversions()
        for i in 0..<conversions.count {
            let sameOriginalCurrency = (conversions[i].query.from == conversion.query.from)
            let sameConvertedCurrency = (conversions[i].query.to == conversion.query.to)
            if sameOriginalCurrency && sameConvertedCurrency {
                return true
            }
        }
        return false
    }
    
    func readSavedConversions() -> [CurrencyConversion] {
        if let savedConversionData = UserDefaults.standard.value(forKey:"conversions") as? Data {
            if let array = try? PropertyListDecoder().decode(Array<CurrencyConversion>.self, from: savedConversionData) {
                return array
            } else {
                return []
            }
        } else {
            return []
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
