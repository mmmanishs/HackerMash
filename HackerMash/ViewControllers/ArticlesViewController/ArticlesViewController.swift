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
import ChameleonFramework
import NVActivityIndicatorView
import AZDropdownMenu
import ESPullToRefresh
import SwipeCellKit

class ArticlesViewController: UIViewController, ScrollingNavigationControllerDelegate {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var activityView: NVActivityIndicatorView!
    
    let controller = ArticlesController()
    var viewModel: ArticlesViewModel?
    let menu = AZDropdownMenu(titles: ["_", "_","• Top Stories", "• Best Stories", "• Saved Stories"])
    var  currentArticleType: ArticleType = .topStories
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        getData()
        tableview.es.addPullToRefresh { [unowned self] in
            self.getData()
        }
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.scrollingNavbarDelegate = self
        }
        TSNotificationCenter.defaultCenter.addObserver(notificationName: "downloadStories", observer: self, selector: #selector(ArticlesViewController.downloadProgress(notification:)))
        self.view.backgroundColor = UIColor.white
        addMenu()
    }
    
    @objc func getData() {
        controller.getData(articlesType: currentArticleType)
    }
    
    @objc func downloadProgress(notification: TSNotification) {
        guard let value = notification.payload as? Float else {
            return
        }
        //        self.navigationController?.setProgress(value, animated: true)
        //        if value == 1.0 {
        //            self.navigationController?.cancelProgress()
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
}



extension ArticlesViewController {
    func scrollingNavigationController(_ controller: AMScrollingNavbar.ScrollingNavigationController, didChangeState state: AMScrollingNavbar.NavigationBarState) {
        //        tableview.frame = self.view.frame
        tableview.frame.size.height = self.view.frame.size.height
        
    }
}

extension ArticlesViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableview, delay: 50, scrollSpeedFactor: 1.0, collapseDirection: .scrollUp, followers: [])
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.showNavbar(animated: true)
        }
    }
}

extension ArticlesViewController {
    @objc func showDropdown() {
        if (self.menu.isDescendant(of: self.view) == true) {
            self.menu.hideMenu()
        } else {
            self.menu.showMenuFromView(self.view)
        }
    }
}
/*
 ballPulse    2. ballGridPulse    3. ballClipRotate    4. squareSpin
 5. ballClipRotatePulse    6. ballClipRotateMultiple    7. ballPulseRise    8. ballRotate
 9. cubeTransition    10. ballZigZag    11. ballZigZagDeflect    12. ballTrianglePath
 13. ballScale    14. lineScale    15. lineScaleParty    16. ballScaleMultiple
 17. ballPulseSync    18. ballBeat    19. lineScalePulseOut    20. lineScalePulseOutRapid
 21. ballScaleRipple    22. ballScaleRippleMultiple    23. ballSpinFadeLoader    24. lineSpinFadeLoader
 25. triangleSkewSpin    26. pacman    27. ballGridBeat    28. semiCircleSpin
 29. ballRotateChase    30. orbit    31. audioEqualizer    32. circleStrokeSpin
 */
