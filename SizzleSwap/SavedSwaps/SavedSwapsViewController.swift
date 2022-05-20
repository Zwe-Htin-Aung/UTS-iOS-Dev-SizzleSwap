//
//  SavedSwapsViewController.swift
//  SizzleSwap
//
//  Created by Saoban Salwa Habib on 17/5/2022.
//

import UIKit

class SavedSwapsViewController: UIViewController {
    
    struct Conversions {
        var from: String
        var to: String
    }
    
    @IBOutlet var tableView: UITableView!
    
    //this is the original data
    //var tableData: [CurrencyConversion] = []
    
    //this is just sample data
    var sampleData = ["AUD -> BDT", "EUR -> USD", "BDT -> USD"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        //self.tableData = readData()
        tableView.reloadData()
        
    }
    
    //original data
    /* func readData() -> [CurrencyConversion]{
        // Read from User Defaults
        // This should happen at the HighScrollViewController
        
        let defaults = UserDefaults.standard;
        
        if let savedArrayData = defaults.value(forKey:"conversionArray") as? Data {
            if let array = try? PropertyListDecoder().decode(Array<CurrencyConversion>.self, from: savedArrayData) {
                return array
            } else {
                return []
            }
        } else {
            return []
        }
    } */
}

//delete saved conversions

extension SavedSwapsViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            tableView.beginUpdates()
            
            sampleData.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
    
    
}

extension SavedSwapsViewController:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //using sample data
        title = sampleData[indexPath.row]
        
        //title = tableData[indexPath.row] as? Any as? String
        
        //let cell = UITableViewCell()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        cell.textLabel?.text = title
        return cell
    }
    
    
}


