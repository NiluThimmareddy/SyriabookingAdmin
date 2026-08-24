//
//  ManageDiscountsTVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 24/08/26.
//

import UIKit

class ManageDiscountsTVC: UITableViewCell {

    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var hotelIdLabel: UILabel!
    @IBOutlet weak var discountNameLabel: UILabel!
    @IBOutlet weak var discountTypeLabel: UILabel!
    @IBOutlet weak var discountValueLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    
    var onCheckmarkTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func checkMarkButtonAction(_ sender: Any) {
        onCheckmarkTapped?()
    }
    
    func configure(with discount: DiscountModel) {
        hotelIdLabel.text = discount.id
        discountNameLabel.text = discount.name
        discountTypeLabel.text = discount.type
        discountValueLabel.text = "\(discount.value)"
        activeLabel.text = discount.activeDate ?? "False"
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
