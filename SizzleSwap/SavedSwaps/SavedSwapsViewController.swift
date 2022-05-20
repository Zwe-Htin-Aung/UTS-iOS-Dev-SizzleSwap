//
//  SavedSwapsViewController.swift
//  SizzleSwap
//
//  Created by Samuel Polgar on 15/5/2022.
//

import UIKit

class SavedSwapsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tableData: [CurrencyConversion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableData = readData()
        tableView.reloadData()
        
    }
    
    func readData() -> [CurrencyConversion]{
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
    }
}

extension SavedSwapsViewController:UITableViewDelegate {
    
}

extension SavedSwapsViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        title = tableData[indexPath.row] as? Any as? String
        
        //let cell = UITableViewCell()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        
        cell.textLabel?.text = title
        
        return cell
    }
    
    
}


