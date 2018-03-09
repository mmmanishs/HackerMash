//
//  ArticlesViewController.swift
//  HackerMash
//
//  Created by Manish Singh on 3/8/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import UIKit
import Promises
class ArticlesViewController: UIViewController  {
    @IBOutlet weak var tableview: UITableView!
    let controller = ArticlesController()
    var viewModel: ArticlesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.getData()
        controller.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ArticlesViewController: ViewModelInteractor {
    func updateView(command: ControllerCommand<ArticlesViewModel>) {
        switch command {
        case .showLoading:
            break
        case .showData(let viewModel):
            self.viewModel = viewModel
            self.tableview.reloadData()
        }
    }
    
}

extension ArticlesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "abc")
        cell.textLabel?.text = viewModel?.rows[indexPath.row].title
        return cell
    }
    
    
}
