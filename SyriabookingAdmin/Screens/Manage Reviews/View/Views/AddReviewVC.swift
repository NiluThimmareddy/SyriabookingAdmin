//
//  AddReviewVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 19/08/26.
//

import UIKit

class AddReviewVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var addReviewTitleLabel: UILabel!
    @IBOutlet weak var reviewerNameLabel: UILabel!
    @IBOutlet weak var reviewerNameTF: UITextField!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var ratingsTF: UITextField!
    @IBOutlet weak var increaseRatingsButton: UIButton!
    @IBOutlet weak var decreaseRatingsButton: UIButton!
    @IBOutlet weak var reviewtextLabel: UILabel!
    @IBOutlet weak var reviewsTextTF: UITextField!
    @IBOutlet weak var cancelbutton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var addReviewIconImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addReviewIconImageView.tintColor = ThemeManager.shared.currentColor
    }
    
    @IBAction func increaseRatingsButtonAction(_ sender: Any) {
    }
    
    @IBAction func decreaseRatingsButtonAction(_ sender: Any) {
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }
}
