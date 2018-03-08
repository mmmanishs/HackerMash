//
//  ViewController.swift
//  HackerMash
//
//  Created by Manish Singh on 3/8/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit
import Promises
class ViewController: UIViewController {

    let viewModel = MainArticlesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel.getData(){ success in
            if success {
                print("In view controller")
                self.viewModel.rows.forEach() { row in
                    print(row.title)
                }
            } else {
                print("Failed to get all data")
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

