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
        guard let rowModel = viewModel?.rows[indexPath.row] else {
            return nil
        }
        if rowModel.isRead {
            let unread = SwipeAction(style: .default, title: "Mark as unread") { action, indexPath in
                guard let stories = self.controller.stories else {
                    return
                }
                let story = stories[indexPath.row]
                self.controller.localDataManager.writeIDAsRead(id: story.id)
                self.viewModel?.rows[indexPath.row].isRead = false
                let cell = tableView.cellForRow(at: indexPath) as? ArticlesTCell
                cell?.setUpIsReadIndicator(isRead: false)
                cell?.hideSwipe(animated: true)
            }
            unread.backgroundColor = UIColor.flatBlue
            return [unread]
            
        } else {
            let read = SwipeAction(style: .default, title: "Mark as read") { action, indexPath in
                guard let stories = self.controller.stories else {
                    return
                }
                let story = stories[indexPath.row]
                self.controller.localDataManager.writeIDAsRead(id: story.id)
                self.viewModel?.rows[indexPath.row].isRead = true
                let cell = tableView.cellForRow(at: indexPath) as? ArticlesTCell
                cell?.setUpIsReadIndicator(isRead: true)
                cell?.hideSwipe(animated: true)
            }
            read.backgroundColor = UIColor.flatPurple
            return [read]
        }
    }
}
