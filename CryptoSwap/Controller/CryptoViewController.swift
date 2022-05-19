//
//  CryptoViewController.swift
//  SizzleSwap
//
//  Created by Samuel Polgar on 15/5/2022.
//

import UIKit
import SwiftUI



class CryptoViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
    }

    @IBOutlet var cryptoViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    let cryptoView = CryptoView()
    let childView = UIHostingController(rootView: cryptoView)
    addChild(childView)
    
    cryptoViewContainer.addSubview(childView.view)
    childView.didMove(toParent: self)
    }
}
