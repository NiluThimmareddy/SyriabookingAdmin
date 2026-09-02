//
//  ManageImagesTVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 01/09/26.
//

import UIKit

class ManageImagesTVC: UITableViewCell {

    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var hotelIdLabel: UILabel!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var displayorderLabel: UILabel!
    
    var onCheckmarkTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        displayorderLabel.layer.masksToBounds = true
    }

    @IBAction func checkmarkButtonAction(_ sender: Any) {
        onCheckmarkTapped?()
    }
    
    func configure(_with images : HotelImageModel) {
        hotelIdLabel.text = images.id
        hotelImageView.image = UIImage(named: images.imageName)
        displayorderLabel.text = "\(images.displayOrder)"
    }
    
    func setSelected(_ isSelected: Bool) {
        let imageName = isSelected ? "checkmark.square.fill" : "square"
        let image = UIImage(systemName: imageName)? .withRenderingMode(.alwaysTemplate)
        checkmarkButton.setImage(image, for: .normal)
        checkmarkButton.tintColor = isSelected ? ThemeManager.shared.currentColor : .lightGray
    }
    
    
}
