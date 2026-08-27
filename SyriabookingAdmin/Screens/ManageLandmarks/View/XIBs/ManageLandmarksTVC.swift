//
//  ManageLandmarksTVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 27/08/26.
//

import UIKit

class ManageLandmarksTVC: UITableViewCell {

    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var landMarkNameLabel: UILabel!
    @IBOutlet weak var landmarkTypeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    
    var onCheckmarkTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func checkmarkButtonAction(_ sender: Any) {
        onCheckmarkTapped?()
    }
    
    
    func configure(with landmark: LandmarkModel) {
        idLabel.text = landmark.id
        landMarkNameLabel.text = landmark.name
        landmarkTypeLabel.text = landmark.type
        distanceLabel.text = "\(landmark.distance)"
        activeLabel.text = landmark.isActive ? "True" : "False"
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
