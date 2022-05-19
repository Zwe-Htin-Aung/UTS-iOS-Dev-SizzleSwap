//
//  SavedSwapsViewController.swift
//  SizzleSwap
//
//  Created by Samuel Polgar on 15/5/2022.
//

import UIKit

class SavedSwapsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let data = UserDefaults.standard.object(forKey: "converted") as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }

}

extension SavedSwapsViewController:UITableViewDelegate {
    
}

extension SavedSwapsViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let title = self.values![indexPath.row]
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "test"
        
        return cell
    }
    
    
}


