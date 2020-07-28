//
//  PhotoListCollectioVC.swift
//  MMagicJsonParsing
//
//  Created by Dipak Dhondge on 28/07/20.
//  Copyright © 2020 Dipak Dhondge. All rights reserved.
//

import UIKit

class PhotoListCollectioVC:  BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var articleCollectionView: UICollectionView!
    
    //MARK:- Vars
    
    private var articlesViewModel: ArticlesViewModel = ArticlesViewModel()
    private let itemsPerRow:CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         performInitialSetupWhileLoadingView()
         articlesViewModel.fetchArticles()
    }
    
    // Function to perform or setup initial settings
       private func performInitialSetupWhileLoadingView() {
           articlesViewModel.delegate = self
           articleCollectionView.delegate = self
           articleCollectionView.dataSource = self
       }
    
    // MARK: UICollectionViewDataSource
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of items
         return articlesViewModel.articleObjects.count
       }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
               as! CategoryCollectionViewCell
           // Configure the cell
        cell.setArticlesOnCellAt(indexPath: indexPath, articleObjects: articlesViewModel.articleObjects)
           return cell
       }

}

//MARK:- Extension for ListResponse Protocol
extension PhotoListCollectioVC: ListResponse {
    func showLoader() {
        self.view.showBlurLoader()
    }
    
    func hideLoader() {
       self.view.removeBluerLoader()
    }
    
    func reloadCollectionView() {
       self.articleCollectionView.reloadData()
    }
    
    func showDataLoadedAlert() {
        self.showAlert(withTitle: Constants.Alerts.alert, withMessage: Constants.Alerts.allDataLoaded)

    }
    
    func showErrorAlert() {
      self.showAlert(withTitle: Constants.Alerts.alert, withMessage: Constants.Alerts.errorMessage)
    }
}

//MARK:- Extension for UICollectionViewFlowLayout
extension PhotoListCollectioVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
         flowLayout.minimumInteritemSpacing = 5
          let totalSpace = flowLayout.sectionInset.left
              + flowLayout.sectionInset.right
              + (flowLayout.minimumInteritemSpacing * CGFloat(itemsPerRow))

          let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(itemsPerRow))
          return CGSize(width: size , height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
