//
//  MyCollectionViewCell.swift
//  homeWork_10
//
//  Created by Дмитрий Яковлев on 26.11.2019.
//  Copyright © 2019 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageCVCell: UIImageView!
    @IBOutlet weak var labelCVC: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(image: UIImage, imageName: String) {
        imageCVCell.image = image

        backgroundColor = UIColor.red
//        labelCVC.text = imageName
    }

    

}
