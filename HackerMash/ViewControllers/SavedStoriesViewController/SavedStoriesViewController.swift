//
//  SavedStoriesViewController.swift
//  HackerMash
//
//  Created by Manish Singh on 6/30/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit

class SavedStoriesViewController: ArticlesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.getData(articlesType: .savedStories)
        // Do any additional setup after loading the view.
    }
}
