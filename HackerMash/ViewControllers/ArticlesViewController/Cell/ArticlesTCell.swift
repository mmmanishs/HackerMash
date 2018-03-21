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
    @IBOutlet weak var isReadIndicatorView: UIView!
    //            imageView.sd_setImage(with: URL(string: urlToImage), placeholderImage: UIImage(named: "placeholderImage"))

    func updateCell(viewModel: ArticlesRowViewModel?) {
        guard let viewModel = viewModel else {
            return
        }
        self.title.text = viewModel.title
        self.time.text = viewModel.time
        
//        if let host = URL(string: viewModel.url)?.host {
//            if let url = StoryIDsRequestProvider.getLogoUrl(domainName: host) {
//                logo.sd_setImage(with: url, placeholderImage: nil)
//            }
//        }
        
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
