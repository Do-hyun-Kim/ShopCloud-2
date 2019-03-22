//
//  CustomCollectionCell.swift
//  Rx_Observable_Test03
//
//  Created by 김도현 on 20/03/2019.
//  Copyright © 2019 김도현. All rights reserved.
//

import UIKit

class CustomCollectionCell: UICollectionViewCell {

    @IBOutlet weak var MainImg: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Money: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
        
    }
    
    public func configure(with model : CellModel){
        MainImg.image = model.image
        category.text = model.category
        Title.text = model.title
        Money.text = "\(model.money)"
    }

}
