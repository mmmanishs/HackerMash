//
//  ArticlesViewController+Tableview.swift
//  HackerMash
//
//  Created by Manish Singh on 3/20/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import UIKit

extension ArticlesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let stories = controller.stories else {
            return
        }
        let story = stories[indexPath.row]
        controller.localDataManager.writeIDAsRead(id: story.id)
        viewModel?.rows[indexPath.row].isRead = true
        let cell = tableView.cellForRow(at: indexPath) as? ArticlesTCell
        cell?.setUpIsReadIndicator(isRead: true)
        controller.localDataManager.writeIDAsRead(id: story.id)
        Router.detailNewsScreen(self, story).route() //refactor with a viewModel here
    }
}

extension ArticlesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesTCell", for: indexPath) as! ArticlesTCell
        if var rowModel = viewModel?.rows[indexPath.row] {
            rowModel.isRead = controller.localDataManager.isIDMarkedAsRead(id: rowModel.id)
            cell.updateCell(viewModel: rowModel)
        }
        cell.delegate = self
        
        return cell
    }
}
