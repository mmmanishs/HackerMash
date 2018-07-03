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
        guard let viewModel = self.viewModel else {
            return
        }
        let story = viewModel.rows[indexPath.row].story
        viewModel.rows[indexPath.row].favorite.isRead = true
        let cell = tableView.cellForRow(at: indexPath) as? ArticleCell
        cell?.setUpIsReadIndicator(isRead: true)
        controller.localDataManagerFavorites.save(favorite: viewModel.rows[indexPath.row].favorite)
        Router.detailNewsScreen(self, story).route() //refactor with a viewModel here
    }
}

extension ArticlesViewController: UITableViewDataSource, ArticleCellResponsder {
    func buttonToggleTapped(cell: UITableViewCell) {
        guard let indexPath = tableview.indexPath(for: cell),
        let viewModel = self.viewModel  else {
            return
        }
        viewModel.rows[indexPath.row].favorite.isSaved.toggle()
        controller.localDataManagerFavorites.save(favorite: viewModel.rows[indexPath.row].favorite)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesTCell", for: indexPath) as! ArticleCell
        if let rowModel = viewModel?.rows[indexPath.row] {
            rowModel.favorite = controller.localDataManagerFavorites.getFavorite(id: rowModel.id) // redundant fetching again
            cell.updateCell(viewModel: rowModel)
        }
        cell.delegate = self
        cell.responder = self
        return cell
    }
}
