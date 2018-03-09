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
import AMScrollingNavbar

class ArticlesViewController: UIViewController, ScrollingNavigationControllerDelegate {
    @IBOutlet weak var tableview: UITableView!
    let controller = ArticlesController()
    var viewModel: ArticlesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.getData()
        controller.delegate = self
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.scrollingNavbarDelegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableview, delay: 50, scrollSpeedFactor: 1.0, collapseDirection: .scrollUp, followers: [tableview])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
}

extension ArticlesViewController: ViewModelInteractor {
    func updateView(viewModel: ArticlesViewModel, command: ControllerCommand) {
        self.viewModel = viewModel
        switch command {
        case .showLoading:
            break
        case .showData:
            self.tableview.reloadData()
        case .showError:
            break
        default: break
        }
        updateView(viewModel: viewModel)
    }
    
    func updateView(viewModel: ArticlesViewModel) {
        self.title = viewModel.title
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

extension ArticlesViewController {
    func scrollingNavigationController(_ controller: AMScrollingNavbar.ScrollingNavigationController, didChangeState state: AMScrollingNavbar.NavigationBarState) {
        
        switch state {
        case .collapsed:
            tableview.frame.size.height = tableview.frame.size.height + 44
        case .expanded:
            tableview.frame.size.height = tableview.frame.size.height - 44
        case .scrolling:
            print("scrolling")
        }
    }
}
