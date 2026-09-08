//
//  ManageRateTVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 04/09/26.
//

import UIKit

class ManageRateTVC: UITableViewCell {

    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var roomIdLabel: UILabel!
    @IBOutlet weak var effectiveDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var localPriceLabel: UILabel!
    @IBOutlet weak var localDiscountLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    var onCheckmarkTapped: (() -> Void)?

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy hh:mm a"
        return formatter
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func checkMarkbuttonAction(_ sender: Any) {
        onCheckmarkTapped?()
    }

    func configure(_with rate: RoomRateModel) {

        roomIdLabel.text = rate.id

        effectiveDateLabel.text = dateFormatter.string(
            from: rate.effectiveDate
        )

        priceLabel.text = "$\(rate.price)"
        noteLabel.text = rate.notes
        localPriceLabel.text = "\(rate.localPrice)"
        localDiscountLabel.text = "\(rate.localDiscount)"
        discountLabel.text = "\(rate.discount)"
    }

    func setSelected(_ isSelected: Bool) {
        let imageName = isSelected ? "checkmark.square.fill" : "square"
        let image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        checkMarkButton.setImage(image, for: .normal)
        checkMarkButton.tintColor = isSelected ? ThemeManager.shared.currentColor : .lightGray
    }
}
