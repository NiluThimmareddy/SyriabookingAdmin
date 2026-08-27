//
//  ViewReviewVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 18/08/26.
//
/*
import UIKit

class ViewReviewVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var reviewerNameLabel: UILabel!
    @IBOutlet weak var reviewerNameTF: UITextField!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingTF: UITextField!
    @IBOutlet weak var increaseRatingButton: UIButton!
    @IBOutlet weak var decreaseRatingButton: UIButton!
    @IBOutlet weak var reviewTextLabel: UILabel!
    @IBOutlet weak var reviewTextTF: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    var review: ReviewModel?
    var onDismiss: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func increaseRatingButtonAction(_ sender: Any) {
    }
    
    @IBAction func decreaseRatingButtonAction(_ sender: Any) {
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
    }
    
    
    
}
*/

import UIKit

class ViewReviewVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var reviewerNameLabel: UILabel!
    @IBOutlet weak var reviewerNameTF: UITextField!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingTF: UITextField!
    @IBOutlet weak var increaseRatingButton: UIButton!
    @IBOutlet weak var decreaseRatingButton: UIButton!
    @IBOutlet weak var reviewTextLabel: UILabel!
    @IBOutlet weak var reviewTextTF: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    @IBOutlet weak var viewReviewIconImageView: UIImageView!
    
    var review: ReviewModel?
    var onDismiss: (() -> Void)?

    private var isEditingReview = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    @IBAction func increaseRatingButtonAction(_ sender: Any) {
        guard isEditingReview else {
            return
        }
        guard let currentRating = Int(ratingTF.text ?? "0") else {
            return
        }
        if currentRating < 5 {
            ratingTF.text = "\(currentRating + 1)"
        }
    }

    @IBAction func decreaseRatingButtonAction(_ sender: Any) {
        guard isEditingReview else {
            return
        }
        guard let currentRating = Int(ratingTF.text ?? "0") else {
            return
        }
        if currentRating > 1 {
            ratingTF.text = "\(currentRating - 1)"
        }
    }

    @IBAction func closeButtonAction(_ sender: Any) {

        onDismiss?()
        dismiss(animated: true)
    }

    @IBAction func editButtonAction(_ sender: Any) {

        if isEditingReview {

            saveReview()

        } else {

            setupEditMode()
        }
    }

    @IBAction func deleteButtonAction(_ sender: Any) {
    }
}


extension ViewReviewVC {
    func setUpUI() {
        viewReviewIconImageView.tintColor = ThemeManager.shared.currentColor
        configureReviewData()
        setupViewMode()
    }
    
    private func configureReviewData() {

        guard let review = review else {
            return
        }

        idTF.text = review.id
        reviewerNameTF.text = review.reviewer
        ratingTF.text = "\(review.rating)"
        reviewTextTF.text = review.review
    }
    private func setupViewMode() {
        isEditingReview = false
        idTF.isUserInteractionEnabled = false
        reviewerNameTF.isUserInteractionEnabled = false
        ratingTF.isUserInteractionEnabled = false
        reviewTextTF.isUserInteractionEnabled = false
        increaseRatingButton.isHidden = true
        decreaseRatingButton.isHidden = true
        deleteButton.isHidden = false
        editButton.isHidden = false
        editButton.setTitle("Edit", for: .normal)
        imgView.image = UIImage(systemName: "eye")
        reviewTitleLabel.text = "View Review"
    }
    
    private func setupEditMode() {
        isEditingReview = true
        idTF.isUserInteractionEnabled = true
        reviewerNameTF.isUserInteractionEnabled = true
        ratingTF.isUserInteractionEnabled = true
        reviewTextTF.isUserInteractionEnabled = true
        increaseRatingButton.isHidden = false
        decreaseRatingButton.isHidden = false
        deleteButton.isHidden = true
        editButton.setTitle("Save", for: .normal)
        imgView.image = UIImage(named: "ic_edit")
        reviewTitleLabel.text = "Edit Review"
    }
    
    private func saveReview() {
        guard let rating = Int(ratingTF.text ?? "") else {
            return
        }
        review = ReviewModel(
            id: idTF.text ?? "",
            reviewer: reviewerNameTF.text ?? "",
            rating: rating,
            review: reviewTextTF.text ?? "",
            created: review?.created ?? ""
        )
        setupViewMode()
    }
}
