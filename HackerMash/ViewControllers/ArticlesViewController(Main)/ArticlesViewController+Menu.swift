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
import AZDropdownMenu

extension ArticlesViewController {
    func configureBarButtons() {
        refershButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(getData))
        navigationItem.rightBarButtonItem = refershButton
    }
    
    @objc func getData() {
        controller.getData(articlesType: currentArticleType)
    }
}
