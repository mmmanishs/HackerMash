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
import RainyRefreshControl

class ArticlesViewController: UIViewController, ScrollingNavigationControllerDelegate {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var activityView: NVActivityIndicatorView!
    
    let controller = ArticlesController()
    var viewModel: ArticlesViewModel?
    let refresh = RainyRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        getData()
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.scrollingNavbarDelegate = self
        }
        TSNotificationCenter.defaultCenter.addObserver(notificationName: "downloadStories", observer: self, selector: #selector(ArticlesViewController.downloadProgress(notification:)))
        self.view.backgroundColor = UIColor.white
        refresh.addTarget(self, action: #selector(ArticlesViewController.getData), for: .valueChanged)
        tableview.addSubview(refresh)
    }
    
    @objc func getData() {
        controller.getData()
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

extension ArticlesViewController: ViewModelInteractor {
    func updateView(viewModel: ArticlesViewModel, command: ControllerCommand) {
        DispatchQueue.main.async {
            self.viewModel = viewModel
            self.activityView.stopAnimating()
            self.activityView.isHidden = true
            switch command {
            case .showLoading:
                self.activityView.isHidden = false
                self.activityView.startAnimating()
                break
            case .showData:
                self.tableview.reloadData()
                self.refresh.endRefreshing()
            case .showError:
                break
            default: break
            }
            self.updateView(viewModel: viewModel)
        }
    }
    
    func updateView(viewModel: ArticlesViewModel) {
        self.title = viewModel.title
    }
}

extension ArticlesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let stories = controller.stories else {
            return
        }
        let story = stories[indexPath.row]
        controller.localDataManager.writeIDAsRead(id: story.id)

        let cell = tableView.cellForRow(at: indexPath) as? ArticlesTCell
        cell?.setUpIsReadIndicator(isRead: true)
        controller.localDataManager.writeIDAsRead(id: story.id)
        Router.detailNewsScreen(self, story).route()
    }
}

extension ArticlesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesTCell", for: indexPath) as! ArticlesTCell
        if var rowModel = viewModel?.rows[indexPath.row] {
            print(rowModel.id)
            rowModel.isRead = controller.localDataManager.isIDMarkedAsRead(id: rowModel.id)
            cell.updateCell(viewModel: rowModel)
        }
        return cell
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
