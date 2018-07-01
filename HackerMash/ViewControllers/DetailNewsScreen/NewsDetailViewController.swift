//
//  NewsDetailViewController.swift
//  NewsMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit
import WebKit
import AMScrollingNavbar
import Popover
import UIView_Shake
class NewsDetailViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    var article: Story?
    @IBOutlet var viewPopover: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = article?.url
        loadWebView(urlString: article?.url)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(navigationTapped))
        navigationController?.navigationBar.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func navigationTapped() {
        guard let navigationFrame = navigationController?.navigationBar.frame else {
            return
        }
        viewPopover.frame.size.width = self.view.frame.width
        viewPopover.frame.size.height = 45

        let startPoint = CGPoint(x: navigationFrame.width - 60, y: navigationFrame.height + 44)
        let popover = Popover()
        popover.show(viewPopover, point: startPoint)
    }
    
    func loadWebView(urlString: String?) {
        guard let urlString = urlString else {
            return
        }
        do {
            let request = try getURLRequest(urlString: urlString)
            webview.load(request)
        } catch {
            print("Error loading news article")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = self.navigationController as? ScrollingNavigationController,
            let tabbar = tabBarController?.tabBar{
            navigationController.followScrollView(webview, delay: 50, scrollSpeedFactor: 1.0, collapseDirection: .scrollUp, followers: [tabbar])
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.showNavbar(animated: true)
        }
    }

    func getURLRequest(urlString: String) throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw ApiError.badURL
        }
        return URLRequest(url: url)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func safariButtonClicked(_ sender: Any) {
        guard let urlString = article?.url,
            let url = URL(string: urlString) else {
                return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func copyButtonClicked(_ sender: Any) {
        guard let urlString = article?.url else {
            return
        }
        let pasteboard = UIPasteboard.general
        pasteboard.string = urlString
        if let button = sender as? UIButton {
            button.shake()
        }
    }
}
extension NewsDetailViewController {
    func scrollingNavigationController(_ controller: AMScrollingNavbar.ScrollingNavigationController, didChangeState state: AMScrollingNavbar.NavigationBarState) {
        
        switch state {
        case .collapsed:
            webview.frame.origin.y = self.view.frame.origin.y
            webview.frame.size.height = self.view.frame.size.height + 44
        case .expanded:
            webview.frame.origin.y = self.view.frame.origin.y + 44
            webview.frame.size.height = self.view.frame.size.height
        case .scrolling:
            print("scrolling")
        }
    }
}
