//
//  CategoryCollectionViewCell.swift
//  MMagicJsonParsing
//
//  Created by Dipak Dhondge on 28/07/20.
//  Copyright © 2020 Dipak Dhondge. All rights reserved.
//

import UIKit
import SDWebImage
class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var imageView:UIImageView!
    
  func setArticlesOnCellAt(indexPath: IndexPath, articleObjects: [ListModel]) {
    nameLabel.text = articleObjects[indexPath.row].author
    let imageURL = URL(string: "https://picsum.photos/300/300?image=\(articleObjects[indexPath.row].id)")
    DispatchQueue.main.async {
        self.imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(contentsOfFile: "default"));
     }
  }
}
