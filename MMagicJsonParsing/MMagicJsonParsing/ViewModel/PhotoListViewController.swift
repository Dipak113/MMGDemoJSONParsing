//
//  PhotoListViewController.swift
//  MMagicJsonParsing
//
//  Created by Dipak Dhondge on 28/07/20.
//  Copyright © 2020 Dipak Dhondge. All rights reserved.
//

import Foundation
import UIKit


protocol ListResponse: class {
    func reloadCollectionView()
    func showDataLoadedAlert()
    func showErrorAlert()
    func showLoader()
    func hideLoader()
}

class ArticlesViewModel: NSObject {
    
    // weak declaration to avoid retain cycle
    var articleObjects: [ListModel] = []
    weak var delegate: ListResponse?
    
    /// Function to call fetch api from model file
    /// - Parameter page: page number
    func fetchArticles() {
        if Reachabilty.HasConnection(){
            self.delegate?.showLoader()
            ServerManager.sharedInstance.getArticleListFromServer() { (articles, error) in
                self.articleObjects.removeAll()
                if error != nil {
                    DispatchQueue.main.async {
                        self.delegate?.hideLoader()
                        self.delegate?.showErrorAlert()
                    }
                }
                else {
                    if let articles = articles {
                        if articles.count == 0 {
                            self.delegate?.showDataLoadedAlert()
                        }
                        DispatchQueue.main.async {
                            self.articleObjects.append(contentsOf: articles)
                            self.delegate?.reloadCollectionView()
                            self.delegate?.hideLoader()
                        }
                    }
                }
            }

        }else{
            print("No internet connection")
        }
    }
}
