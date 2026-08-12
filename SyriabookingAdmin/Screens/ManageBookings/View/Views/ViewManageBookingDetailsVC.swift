//
//  ViewManageBookingDetailsVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 10/08/26.
//

import UIKit

class ViewManageBookingDetailsVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var bookingDetailsView: UIView!
    @IBOutlet weak var bookingDetailsTitleLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var bookingIdTitleLabel: UILabel!
    @IBOutlet weak var bookingIdLabel: UILabel!
    @IBOutlet weak var statusTitleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var bookingTypeTitleLabel: UILabel!
    @IBOutlet weak var bookingTypeLabel: UILabel!
    @IBOutlet weak var totalAmountTitleLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var discountTitleLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var netAmountTitleLabel: UILabel!
    @IBOutlet weak var netAmountLabel: UILabel!
    @IBOutlet weak var checkInAndCheckOutTitleLabel: UILabel!
    @IBOutlet weak var checkInAndCheckOutDatesLabel: UILabel!
    @IBOutlet weak var guestsTitlelabel: UILabel!
    @IBOutlet weak var guestsLabel: UILabel!
    @IBOutlet weak var primaryGuestNameLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var registeredGuestListLabel: UILabel!
    @IBOutlet weak var addGuestButton: UIButton!
    @IBOutlet weak var registeredGuestView: UIView!
    @IBOutlet weak var fullNameButton: UIButton!
    @IBOutlet weak var phoneNoButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var dobButton: UIButton!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var noguestsRegisteredButton: UIButton!
    @IBOutlet weak var paymentDetailsLabel: UILabel!
    @IBOutlet weak var addPaymentButton: UIButton!
    @IBOutlet weak var paymentDetailsView: UIView!
    @IBOutlet weak var noPaymentsFoundButton: UIButton!
    @IBOutlet weak var registeredGuestListStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registeredGuestListStackView.layer.cornerRadius = 10
        registeredGuestListStackView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        registeredGuestListStackView.clipsToBounds = true
        
        updateButton.applyOverviewGradient()
        addGuestButton.applyOverviewGradient()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        paymentDetailsView.layoutIfNeeded()
        paymentDetailsView.addDashedBorder()
    }

    @IBAction func updateButtonaction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "ViewBookingVC") as! ViewBookingVC
        present(storyboard, animated: true)
    }
    
    @IBAction func addGuestButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "AddGuestVC") as! AddGuestVC
        present(storyboard, animated: true)
    }
    
    @IBAction func addPaymentButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "AddPaymentVC") as! AddPaymentVC
        present(storyboard, animated: true)
    }
}
