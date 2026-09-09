//
//  RoomFacilityTVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 08/09/26.
//

import UIKit

class RoomFacilityTVC: UITableViewCell {

    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var roomIdLabel: UILabel!
    @IBOutlet weak var facilityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var onCheckmarkTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func checkMarkbuttonAction(_ sender: Any) {
        onCheckmarkTapped?()
    }
    
    func configure(_with roomFacilities : RoomFacility) {
        roomIdLabel.text = roomFacilities.id
        facilityLabel.text = roomFacilities.facility
        descriptionLabel.text = roomFacilities.description
    }
    
    func setSelected(_ isSelected: Bool) {
        let imageName = isSelected ? "checkmark.square.fill" : "square"
        let image = UIImage(systemName: imageName)? .withRenderingMode(.alwaysTemplate)
        checkMarkButton.setImage(image, for: .normal)
        checkMarkButton.tintColor = isSelected ? ThemeManager.shared.currentColor : .lightGray
    }
    
}
