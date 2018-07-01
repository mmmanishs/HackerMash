//
//  MainStoriesViewController.swift
//  HackerMash
//
//  Created by Manish Singh on 6/30/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit

class MainStoriesViewController: ArticlesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.getData(articlesType: .topStories)
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refershButton?.isEnabled = true
    }
}
