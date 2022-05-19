//
//  SavedSwapsViewController.swift
//  SizzleSwap
//
//  Created by Samuel Polgar on 15/5/2022.
//

import UIKit

class SavedSwapsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tabledata = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tabledata = UserDefaults.standard.array(forKey: "conversionArray") ?? []
        tableView.reloadData()
        
    }

}

extension SavedSwapsViewController:UITableViewDelegate {
    
}

extension SavedSwapsViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabledata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        title = tabledata[indexPath.row] as? String
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = title
        
        return cell
    }
    
    
}


