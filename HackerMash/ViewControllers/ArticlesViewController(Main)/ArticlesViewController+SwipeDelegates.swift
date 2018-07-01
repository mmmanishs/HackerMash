//
//  ArticlesViewController+SwipeDelegates.swift
//  HackerMash
//
//  Created by Manish Singh on 3/20/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import SwipeCellKit

extension ArticlesViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        guard let viewModel = self.viewModel  else {
            return nil
        }
        let isRead = viewModel.rows[indexPath.row].favorite.isRead
        let isSaved = viewModel.rows[indexPath.row].favorite.isSaved
        let makeUnread = SwipeAction(style: .default, title: "○") { action, indexPath in
            viewModel.rows[indexPath.row].favorite.isRead = false

            let cell = tableView.cellForRow(at: indexPath) as? ArticlesTCell
            cell?.setUpIsReadIndicator(isRead: false, isSaved: isSaved)
            cell?.hideSwipe(animated: true)
            self.controller.localDataManagerFavorites.save(favorite: viewModel.rows[indexPath.row].favorite)

        }
        makeUnread.backgroundColor = UIColor.flatWhite
        makeUnread.font = UIFont(name: "Helvetica", size: 20.0)
        makeUnread.textColor = UIColor.flatBlue

        let makeRead = SwipeAction(style: .default, title: "●") { action, indexPath in

            viewModel.rows[indexPath.row].favorite.isRead = true
            let cell = tableView.cellForRow(at: indexPath) as? ArticlesTCell
            cell?.setUpIsReadIndicator(isRead: true, isSaved: isSaved)
            cell?.hideSwipe(animated: true)
            self.controller.localDataManagerFavorites.save(favorite: viewModel.rows[indexPath.row].favorite)

        }
        makeRead.backgroundColor = UIColor.flatWhite
        makeRead.font = UIFont(name: "Helvetica", size: 40.0)
        makeRead.textColor = UIColor.flatBlue

        let makeSave = SwipeAction(style: .default, title: "📖") { action, indexPath in
            viewModel.rows[indexPath.row].favorite.isSaved = !viewModel.rows[indexPath.row].favorite.isSaved
            let cell = tableView.cellForRow(at: indexPath) as? ArticlesTCell
            cell?.setUpIsReadIndicator(isRead: isRead, isSaved: true)
            cell?.hideSwipe(animated: true)
            self.controller.localDataManagerFavorites.save(favorite: viewModel.rows[indexPath.row].favorite)

        }
        makeSave.backgroundColor = UIColor.flatWhite
        makeSave.font = UIFont(name: "Helvetica", size: 20.0)
        
        let makeUnSave = SwipeAction(style: .default, title: "un-bookmark") { action, indexPath in
            viewModel.rows[indexPath.row].favorite.isSaved.toggle()
            let cell = tableView.cellForRow(at: indexPath) as? ArticlesTCell
            cell?.setUpIsReadIndicator(isRead: isRead, isSaved: false)
            cell?.hideSwipe(animated: true)
            self.controller.localDataManagerFavorites.save(favorite: viewModel.rows[indexPath.row].favorite)

        }
        makeUnSave.backgroundColor = UIColor.flatBlue
        makeUnSave.font = UIFont(name: "Helvetica", size: 20.0)


        switch (true,true) {
        case (isRead, isSaved): return [makeUnread, makeUnSave]
        case (isRead, !isSaved): return [makeUnread, makeSave]
        case (!isRead, isSaved): return [makeRead, makeUnSave]
        case (!isRead, !isSaved): return [makeRead, makeSave]
        default :  return [makeUnread, makeUnSave]
        }
    }

}
