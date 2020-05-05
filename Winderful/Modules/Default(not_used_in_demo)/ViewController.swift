//
//  ViewController.swift
//  Winderful
//
//  Created by Владимир Елизаров on 03.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func resetBadge(_ sender: Any) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

}

