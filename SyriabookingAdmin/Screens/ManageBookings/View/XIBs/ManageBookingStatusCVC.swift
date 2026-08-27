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
    
    func configure(_with bookingStatus: BookingStatusModel,isSelected: Bool) {
        statusIconImgView.image = UIImage(systemName: bookingStatus.iconName)
        statusTitleLabel.text = bookingStatus.title        
        let selectedColor = ThemeManager.shared.currentColor
        let normalColor = UIColor(hex: "#575757")
        
        backView.layer.cornerRadius = 12
        backView.layer.borderWidth = 1
        
        statusCountLabel.layer.cornerRadius = 8
        statusCountLabel.clipsToBounds = true
        
        if isSelected {
            statusCountLabel.backgroundColor = ThemeManager.shared.currentColor
            backView.layer.borderColor = selectedColor.cgColor
            
            backgroundColourView.backgroundColor =
                selectedColor.withAlphaComponent(0.1)
            
            statusIconImgView.tintColor = selectedColor
            
            statusCountLabel.textColor = .white
            
            
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
