//
//  ArchivesViewController.swift
//  HackerMash
//
//  Created by Manish Singh on 7/1/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit

class ArchivesViewController: ArticlesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.getData(articlesType: .archives)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
