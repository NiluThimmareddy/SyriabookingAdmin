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
    @IBOutlet weak var roomDetailsTitleLabel: UILabel!
    @IBOutlet weak var roomDetailsView: UIView!
    @IBOutlet weak var hotelImgView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var bedLabel: UILabel!
    @IBOutlet weak var bedTypeLabel: UILabel!
    @IBOutlet weak var breakfastLabel: UILabel!
    @IBOutlet weak var breakFastincludeLabel: UILabel!
    @IBOutlet weak var amenitiesLabel: UILabel!
    @IBOutlet weak var amenitiesCollectionView: UICollectionView!
    @IBOutlet weak var priceDetailsLabel: UIView!
    @IBOutlet weak var userInformationLabel: UIView!
    @IBOutlet weak var userInformationButton: UIButton!
    
    let amenities : [AmenitiesModel] = [
        AmenitiesModel(icon: "wifi", title: "WiFi"),
        AmenitiesModel(icon: "square.split.bottomrightquarter", title: "Room Service"),
        AmenitiesModel(icon: "air.conditioner.horizontal", title: "Air Conditioning"),
        AmenitiesModel(icon: "bed.double", title: "Extra Pillows"),
        AmenitiesModel(icon: "heater.vertical", title: "Heater"),
        AmenitiesModel(icon: "tv", title: "Television"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registeredGuestListStackView.layer.cornerRadius = 10
        registeredGuestListStackView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        registeredGuestListStackView.clipsToBounds = true
        
        updateButton.applyOverviewGradient(color: ThemeManager.shared.currentColor)
        addGuestButton.applyOverviewGradient(color: ThemeManager.shared.currentColor)
        
        amenitiesCollectionView.register(UINib(nibName: "AmenitiesCVC", bundle: nil), forCellWithReuseIdentifier: "AmenitiesCVC")
        if let layout = amenitiesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = CGSize(width: 1, height: 30)
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 8
            layout.sectionInset = .zero
        }
        amenitiesCollectionView.isScrollEnabled = false
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

extension ViewManageBookingDetailsVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amenities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmenitiesCVC", for: indexPath) as! AmenitiesCVC
        let amenities = amenities[indexPath.row]
        cell.configure(_with: amenities)
        return cell
    }
}

