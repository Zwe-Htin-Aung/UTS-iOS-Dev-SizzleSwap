//
//  SavedSwapsViewController.swift
//  SizzleSwap
//
//  Created by Saoban Salwa Habib on 17/5/2022.
//

import UIKit

class SavedSwapsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var conversions: [CurrencyConversion] = []
    //var conversions = ["AUD -> BDT", "EUR -> USD", "BDT -> USD"]
    let defaults = UserDefaults.standard;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conversions = readSavedConversions()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    // load data
    func readSavedConversions() -> [CurrencyConversion] {
        if let savedConversionData = defaults.value(forKey:"conversions") as? Data {
            if let array = try? PropertyListDecoder().decode(Array<CurrencyConversion>.self, from: savedConversionData) {
                return array
            } else {
                return []
            }
        } else {
            return []
        }
    }
}

//delete saved conversions

extension SavedSwapsViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            conversions.remove(at: indexPath.row)
            defaults.set(try? PropertyListEncoder().encode(conversions), forKey: "conversions")
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "CurrencyViewController") as! CurrencyViewController;
        VC.from = conversions[indexPath.row].query.from
        VC.to = conversions[indexPath.row].query.to
        self.navigationController?.pushViewController(VC, animated: true);
        VC.navigationItem.setHidesBackButton(true, animated: true);
    }
}

extension SavedSwapsViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        cell.textLabel?.text = String(conversions[indexPath.row].query.from)
        cell.detailTextLabel?.text = String(conversions[indexPath.row].query.to)
        return cell
    }
    
    
}


