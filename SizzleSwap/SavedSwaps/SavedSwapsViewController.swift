//
//  SavedSwapsViewController.swift
//  SizzleSwap
//
//  Created by Samuel Polgar on 15/5/2022.
//

import UIKit

class SavedSwapsViewController: UIViewController {
    
    let names = ["daisy", "lily", "boby", "scooby", "satang"]
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        //let value = UserDefaults.standard.string(forKey: "converted")
    }

}

extension SavedSwapsViewController:UITableViewDelegate {
    
}

extension SavedSwapsViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.names.count
        //return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let title = self.names[indexPath.row]
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = title
        
        return cell
    }
    
    
}


