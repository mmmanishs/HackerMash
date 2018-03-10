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
    @IBOutlet weak var isReadIndicatorView: UIView!
    
    func updateCell(viewModel: ArticlesRowViewModel?) {
        guard let viewModel = viewModel else {
            return
        }
        self.title.text = viewModel.title
        self.time.text = viewModel.time
        setUpIsReadIndicator(isRead: viewModel.isRead)
    }
    
    func setUpIsReadIndicator(isRead: Bool) {
        if isRead {
            isReadIndicatorView.backgroundColor = UIColor.flatOrange
        } else {
            isReadIndicatorView.backgroundColor = UIColor.clear
            isReadIndicatorView.layer.borderWidth = 1.0
            isReadIndicatorView.layer.borderColor = UIColor.flatOrange.cgColor
        }
    }
}
