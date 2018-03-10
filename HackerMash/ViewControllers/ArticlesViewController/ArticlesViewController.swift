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

class ArticlesViewController: UIViewController, ScrollingNavigationControllerDelegate {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var activityView: NVActivityIndicatorView!
    
    let controller = ArticlesController()
    var viewModel: ArticlesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        controller.getData()
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.scrollingNavbarDelegate = self
        }
        
        self.view.backgroundColor = UIColor.white
        
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
}

extension ArticlesViewController: ViewModelInteractor {
    func updateView(viewModel: ArticlesViewModel, command: ControllerCommand) {
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
        case .showError:
            break
        default: break
        }
        updateView(viewModel: viewModel)
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
//        Router.showKidsScreen(self, stories[indexPath.row].kids).route()
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
        cell.updateCell(viewModel: viewModel?.rows[indexPath.row])
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
