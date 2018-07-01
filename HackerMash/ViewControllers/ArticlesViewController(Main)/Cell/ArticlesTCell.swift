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

protocol ArticleCellResponsder {
    func buttonToggleTapped(cell: UITableViewCell)
}
class ArticlesTCell: SwipeTableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var buttonBookmark: UIButton!
    //    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var isReadIndicatorLabel: UILabel!
    //            imageView.sd_setImage(with: URL(string: urlToImage), placeholderImage: UIImage(named: "placeholderImage"))
    @IBOutlet weak var borderColorView: UIView!
    var responder: ArticleCellResponsder?
    var viewModel: ArticlesRowViewModel?
    func updateCell(viewModel: ArticlesRowViewModel?) {
        guard let viewModel = viewModel else {
            return
        }
        self.viewModel = viewModel
        self.title.text = viewModel.title
        self.time.text = viewModel.time + " by \(viewModel.story.by)"
        setUpIsReadIndicator(isRead: viewModel.favorite.isRead)
        buttonBookmark.setBackgroundImage(getButtonImage(isSaved: viewModel.favorite.isSaved), for: .normal)
        borderColorView.backgroundColor = getRandomColor()
    }
    
    func setUpIsReadIndicator(isRead: Bool) {
        if isRead {
            isReadIndicatorLabel.font = UIFont(name: FontName.HelveticaNeue.getString(), size: 22.0)
            isReadIndicatorLabel.text = "●"
        } else {
            isReadIndicatorLabel.font = UIFont(name: FontName.HelveticaNeue.getString(), size: 13.0)
            isReadIndicatorLabel.text = "○"
        }
    }
    
    private func getButtonImage(isSaved: Bool) -> UIImage {
        if isSaved {
            return UIImage(named: "bookmark")!
        } else {
            return UIImage(named: "unbookmark")!

        }
    }
    
    @IBAction func buttonBookmarkClicked(_ sender: Any) {
        guard let viewModel = viewModel else {
            return
        }
        responder?.buttonToggleTapped(cell: self)
        buttonBookmark.setBackgroundImage(getButtonImage(isSaved: viewModel.favorite.isSaved), for: .normal)
    }
}

