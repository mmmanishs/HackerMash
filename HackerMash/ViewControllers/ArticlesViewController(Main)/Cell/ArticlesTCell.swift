//
//  ArticlesTCell.swift
//  HackerMash
//
//  Created by Manish Singh on 3/8/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SwipeCellKit

class ArticlesTCell: SwipeTableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    //    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var isReadIndicatorLabel: UILabel!
    //            imageView.sd_setImage(with: URL(string: urlToImage), placeholderImage: UIImage(named: "placeholderImage"))
    @IBOutlet weak var borderColorView: UIView!
    
    func updateCell(viewModel: ArticlesRowViewModel?) {
        guard let viewModel = viewModel else {
            return
        }
        self.title.text = viewModel.title
        self.time.text = viewModel.time + " by \(viewModel.story.by)"
        setUpIsReadIndicator(isRead: viewModel.favorite.isRead, isSaved: viewModel.favorite.isSaved)
        borderColorView.backgroundColor = getRandomColor()
    }
    
    func setUpIsReadIndicator(isRead: Bool, isSaved: Bool) {
        switch true {
        case isRead:
            isReadIndicatorLabel.font = UIFont(name: FontName.HelveticaNeue.getString(), size: 22.0)
            isReadIndicatorLabel.text = "●"
        case !isRead:
            isReadIndicatorLabel.font = UIFont(name: FontName.HelveticaNeue.getString(), size: 13.0)
            isReadIndicatorLabel.text = "○"
        default : isReadIndicatorLabel.text = "○"
        }
    }
}

