//
//  ArticlesTCell.swift
//  HackerMash
//
//  Created by Manish Singh on 3/8/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import UIKit
class ArticlesTCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
//    @IBOutlet weak var commentsCount: UILabel!
    
    func updateCell(viewModel: ArticlesRowViewModel?) {
        guard let viewModel = viewModel else {
            return
        }
        self.title.text = viewModel.title
        self.time.text = viewModel.time
    }
}
