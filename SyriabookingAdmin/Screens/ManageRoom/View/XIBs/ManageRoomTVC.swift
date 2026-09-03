//
//  ManageRoomTVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 02/09/26.
//

import UIKit

class ManageRoomTVC: UITableViewCell {

    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var bedTypeLabel: UILabel!
    @IBOutlet weak var maxAdultsLabel: UILabel!
    @IBOutlet weak var maxChildrenLabel: UILabel!
    @IBOutlet weak var basePriceLabel: UILabel!
    @IBOutlet weak var breakfastLabel: UILabel!
    @IBOutlet weak var roomStatusLabel: UILabel!
    
    var onCheckmarkTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func checkMarkButtonAction(_ sender: Any) {
        onCheckmarkTapped?()
    }
    
    func configure(with room: RoomModel) {
        roomTypeLabel.text = room.roomType
        bedTypeLabel.text = room.bedType
        maxAdultsLabel.text = "\(room.maxAdults)"
        maxChildrenLabel.text = "\(room.maxChildren)"
        basePriceLabel.text = "$\(room.basePrice)"
        breakfastLabel.text = room.breakfast ? "True" : "False"
        roomStatusLabel.text = room.roomStatus
    }
    
    func setSelected(_ isSelected: Bool) {
        let imageName = isSelected ? "checkmark.square.fill" : "square"
        let image = UIImage(systemName: imageName)? .withRenderingMode(.alwaysTemplate)
        checkMarkButton.setImage(image, for: .normal)
        checkMarkButton.tintColor = isSelected ? ThemeManager.shared.currentColor : .lightGray
    }
    
}
