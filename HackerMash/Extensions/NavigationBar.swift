//
//  UIViewController+NavigationBar.swift
//  HackerMash
//
//  Created by Manish Singh on 3/10/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import UIKit

//extension UIViewController {
//    func navigationBarColor() {
//        UINavigationBar.appearance().tintColor = UIColor.white
//        UINavigationBar.appearance().barTintColor = UIColor.flatOrange
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
//    }
//}

enum ColorScheme {
    case orangeWhite
    case blueWhite
    case redWhite
    case blackWhite
    func apply() {
        switch self {
        case .orangeWhite:
            UINavigationBar.appearance().tintColor = UIColor.white
            UINavigationBar.appearance().barTintColor = UIColor.flatOrange
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        case .blueWhite:
            UINavigationBar.appearance().tintColor = UIColor.white
            UINavigationBar.appearance().barTintColor = UIColor.flatBlue
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        case .redWhite:
            UINavigationBar.appearance().tintColor = UIColor.white
            UINavigationBar.appearance().barTintColor = UIColor.flatRed
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        case .blackWhite:
            UINavigationBar.appearance().tintColor = UIColor.white
            UINavigationBar.appearance().barTintColor = UIColor.flatBlack
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
            
        }
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
}
