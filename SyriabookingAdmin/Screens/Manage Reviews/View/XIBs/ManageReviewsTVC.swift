//
//  ManageReviewsTVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 18/08/26.
//

import UIKit

class ManageReviewsTVC: UITableViewCell {

    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var reviewerLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var ratingsView: CosmosView!
    
    var onCheckmarkTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func checkmarkButtonAction(_ sender: Any) {
        onCheckmarkTapped?()
    }
    
    func configure(_with reviews : ReviewModel) {
        idLabel.text = reviews.id
        reviewerLabel.text = reviews.reviewer
        reviewLabel.text = reviews.review
        createdLabel.text = reviews.created
        ratingsView.rating = Double(reviews.rating)
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
