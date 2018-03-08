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

    @IBOutlet weak var tableview: UITableView!

    let viewModel = MainArticlesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel.getData(){ success in
            if success {
                print("In view controller")
                self.tableview.reloadData()
//                self.viewModel.rows.forEach() { row in
////                    print(row.title)
//                }
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

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "abc")
        cell.textLabel?.text = viewModel.rows[indexPath.row].title
        return cell
    }
    
    
}
