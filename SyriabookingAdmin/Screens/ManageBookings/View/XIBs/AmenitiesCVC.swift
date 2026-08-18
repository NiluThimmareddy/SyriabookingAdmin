//
//  AmenitiesCVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 17/08/26.
//

import UIKit

class AmenitiesCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var amenitiesTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_with amenities : AmenitiesModel) {
        iconImgView.image = UIImage(systemName: "\(amenities.icon)")
        amenitiesTypeLabel.text = amenities.title
    }
}
