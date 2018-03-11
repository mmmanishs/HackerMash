//
//  ArticlesViewController+Menu.swift
//  HackerMash
//
//  Created by Manish Singh on 3/11/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import UIKit
import Promises
import AMScrollingNavbar
import ChameleonFramework
import NVActivityIndicatorView
import RainyRefreshControl
import AZDropdownMenu

extension ArticlesViewController {
    func addMenu() {
        menu.itemFontColor = UIColor.flatBlack
        menu.itemFontSize = 16.0
        menu.menuSeparatorColor = UIColor.orange
        menu.itemColor = UIColor.white
        menu.itemFontName = FontName.HelveticaNeue_Italic.getString()
        let menuButton = UIBarButtonItem(title: "⌘", style: .plain, target: self, action: #selector(showDropdown))
        navigationItem.rightBarButtonItem = menuButton
        menu.cellTapHandler = { [weak self] (indexPath: IndexPath) -> Void in
            switch indexPath.row {
            case 2:
                self?.currentArticleType = .topStories
            case 3:
                self?.currentArticleType = .bestStories
            case 4:
                self?.currentArticleType = .savedStories
            default:
                break
            }
            self?.getData()
        }
    }
}
