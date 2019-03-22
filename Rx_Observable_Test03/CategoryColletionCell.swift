//
//  CategoryColletionCell.swift
//  Rx_Observable_Test03
//
//  Created by 김도현 on 21/03/2019.
//  Copyright © 2019 김도현. All rights reserved.
//

import UIKit

class CategoryColletionCell: UICollectionViewCell {

    @IBOutlet weak var CategoryImg: UIImageView!
    @IBOutlet weak var Categorytitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(with model : CategoryModel){
       CategoryImg.image = model.categoryimage
       Categorytitle.text = model.categorytitle
    }

}
