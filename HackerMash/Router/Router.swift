//
//  Router.swift
//  HackerMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import UIKit
enum Router {
    case detailNewsScreen(UIViewController, Story?)
    case showKidsScreen(UIViewController, [Int])

    func route() {
        switch self {
        case .detailNewsScreen(let vc, let article):
            let newsDetailViewController = NewsDetailViewController(nibName: "NewsDetailViewController", bundle: nil)
            newsDetailViewController.article = article
            vc.navigationController?.pushViewController(newsDetailViewController, animated: true)
        case .showKidsScreen(let vc, let kids):
            let kidsArticlesController = KidsArticlesController(storyIds: kids)
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let kidsVC: KidsArticlesViewController = mainStoryboard.instantiateViewController(withIdentifier: "KidsArticlesViewController") as! KidsArticlesViewController
            kidsVC.controller = KidsArticlesController(storyIds: kids)
            kidsArticlesController.delegate = kidsVC
            vc.navigationController?.pushViewController(kidsVC, animated: true)
        }
    }
}

