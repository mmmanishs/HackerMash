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
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        controller.getData(articlesType: .savedStories)
        refershButton?.isEnabled = false
    }
}
