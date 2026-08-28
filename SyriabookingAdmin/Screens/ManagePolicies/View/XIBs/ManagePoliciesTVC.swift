//
//  ManagePoliciesTVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 27/08/26.
//

import UIKit

class ManagePoliciesTVC: UITableViewCell {

    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    
    var onCheckmarkTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func checkmarkButtonAction(_ sender: Any) {
        onCheckmarkTapped?()
    }
    
    func configure(with policy: PolicyModel) {
        idLabel.text = policy.id
        titleLabel.text = policy.title
        descriptionLabel.text = policy.description
        activeLabel.text = policy.isActive ? "True" : "False"
    }
    
    func setSelected(_ isSelected: Bool) {
        let imageName = isSelected ? "checkmark.square.fill" : "square"

        let image = UIImage(systemName: imageName)?
            .withRenderingMode(.alwaysTemplate)

        checkmarkButton.setImage(image, for: .normal)
        checkmarkButton.tintColor = isSelected
        ? ThemeManager.shared.currentColor
            : .lightGray
    }
}
