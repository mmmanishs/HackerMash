//
//  ArticlesViewController+Interactor.swift
//  HackerMash
//
//  Created by Manish Singh on 3/20/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

extension ArticlesViewController: ViewModelInteractor {
    func updateView(viewModel: ArticlesViewModel, command: ControllerCommand) {
        DispatchQueue.main.async {
            self.viewModel = viewModel
            self.activityView.stopAnimating()
            self.activityView.isHidden = true
            switch command {
            case .showLoading:
                self.activityView.isHidden = false
                self.activityView.startAnimating()
                self.tableview.isUserInteractionEnabled = false
                break
            case .showData:
                self.tableview.reloadData()
                self.tableview.isUserInteractionEnabled = true
                
            case .showError:
                break
            default: break
            }
            self.updateView(viewModel: viewModel)
        }
    }
    
    func updateView(viewModel: ArticlesViewModel) {
        self.title = viewModel.title
        
    }
}
