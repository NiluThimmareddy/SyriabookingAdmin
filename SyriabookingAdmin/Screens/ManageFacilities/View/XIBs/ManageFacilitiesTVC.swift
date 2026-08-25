//
//  ManageFacilitiesTVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 25/08/26.
//

import UIKit

class ManageFacilitiesTVC: UITableViewCell {

    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var facilityLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    
    var onCheckmarkTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func checkMarkButtonAction(_ sender: Any) {
        onCheckmarkTapped?()
    }
    
    func configure(_with facility : FacilityModel) {
        idLabel.text = facility.id
        facilityLabel.text = facility.facility
        noteLabel.text = facility.notes
        activeLabel.text = facility.isActive ? "True" : "False"
    }
    
    func setSelected(_ isSelected: Bool) {
        let imageName = isSelected ? "checkmark.square.fill" : "square"

        let image = UIImage(systemName: imageName)?
            .withRenderingMode(.alwaysTemplate)

        checkMarkButton.setImage(image, for: .normal)
        checkMarkButton.tintColor = isSelected
            ? UIColor(hex: "#379D67")
            : .lightGray
    }
}
