//
//  ArticlesContainerViewController.swift
//  HackerMash
//
//  Created by Manish Singh on 7/1/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit

class ArticlesContainerViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let index = self.tabBarController?.selectedIndex,
            let articlesViewController = self.childViewControllers[0] as? ArticlesViewController {
            switch index {
            case 0:
                DispatchQueue.global(qos: .userInitiated).async {
                    articlesViewController.controller.getData(articlesType: .topStories)
                }
                title = "Top Stories"
            case 1: title = "Bookmarked"
            case 2:
                DispatchQueue.global(qos: .userInitiated).async {
                    articlesViewController.controller.getData(articlesType: .archives)
                }
                title = "Archives"
            default: break
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let index = tabBarController?.selectedIndex,
            let articlesViewController = childViewControllers[0] as? ArticlesViewController {
            switch index {
            case 1:
                DispatchQueue.global(qos: .userInitiated).async {
                    articlesViewController.controller.getData(articlesType: .savedStories)
                }
            default: break
            }
        }
    }
}
