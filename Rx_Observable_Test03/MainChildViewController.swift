//
//  MainChildViewController.swift
//  Rx_Observable_Test03
//
//  Created by Kim dohyun on 09/04/2019.
//  Copyright © 2019 김도현. All rights reserved.
//

import UIKit

class MainChildViewController: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var categoryModel : [CategoryModel] = [CategoryModel(categoryimage: UIImage(named: "Test03")!, categorytitle: "IT분야"),CategoryModel(categoryimage: UIImage(named: "Test03")!, categorytitle: "테스트 카테고리")]

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return categoryModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryColletionCell", for: indexPath) as? CategoryColletionCell
            cell?.configure(with: categoryModel[indexPath.row])
            cell?.contentView.layer.borderColor = UIColor.gray.cgColor
            cell?.contentView.layer.borderWidth = 1.0
            cell?.layer.masksToBounds = false
            return cell!
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
