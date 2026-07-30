//
//  ManageBookingStatusCVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 30/07/26.
//

import UIKit

class ManageBookingStatusCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backgroundColourView: UIView!
    @IBOutlet weak var statusIconImgView: UIImageView!
    @IBOutlet weak var statusTitleLabel: UILabel!
    @IBOutlet weak var statusCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        statusCountLabel.layer.masksToBounds = true
    }
    
//    func configure(_with bookingStatus : BookingStatusModel) {
//        statusIconImgView.image = UIImage(systemName: bookingStatus.iconName)
//        statusTitleLabel.text = bookingStatus.title
//        statusCountLabel.text = bookingStatus.count
//    }
    
    func configure(_with bookingStatus: BookingStatusModel,
                   isSelected: Bool) {
        
        statusIconImgView.image = UIImage(systemName: bookingStatus.iconName)
        statusTitleLabel.text = bookingStatus.title
        statusCountLabel.text = bookingStatus.count
        
        let selectedColor = UIColor(hex: "#379D67")
        let normalColor = UIColor(hex: "#575757")
        
        backView.layer.cornerRadius = 12
        backView.layer.borderWidth = 1
        
        statusCountLabel.layer.cornerRadius = 8
        statusCountLabel.clipsToBounds = true
        
        if isSelected {
            
            backView.layer.borderColor = selectedColor.cgColor
            
            backgroundColourView.backgroundColor =
                selectedColor.withAlphaComponent(0.1)
            
            statusIconImgView.tintColor = selectedColor
            
            statusCountLabel.textColor = .white
            statusCountLabel.backgroundColor = UIColor(hex: "#F97316")
            
        } else {
            
            backView.layer.borderColor = UIColor.clear.cgColor
            
            backgroundColourView.backgroundColor =
                normalColor.withAlphaComponent(0.1)
            
            statusIconImgView.tintColor = normalColor
            
            statusCountLabel.textColor = .label
            statusCountLabel.backgroundColor = .clear
        }
    }

}
