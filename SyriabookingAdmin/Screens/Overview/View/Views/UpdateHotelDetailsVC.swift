//
//  UpdateHotelDetailsVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 21/07/26.
//

/*
 import UIKit

 class UpdateHotelDetailsVC: UIViewController {

     @IBOutlet weak var topView: UIView!
     @IBOutlet weak var updateHotelDetailsTitleLabel: UILabel!
     @IBOutlet weak var basicLineView: UIView!
     @IBOutlet weak var basicButton: UIButton!
     @IBOutlet weak var locationLineView: UIView!
     @IBOutlet weak var locationButton: UIButton!
     @IBOutlet weak var descriptionLineView: UIView!
     @IBOutlet weak var descriptionButton: UIButton!
     @IBOutlet weak var bottomView: UIView!
     @IBOutlet weak var cancelbutton: UIButton!
     @IBOutlet weak var saveButton: UIButton!
     @IBOutlet weak var publishButton: UIButton!
     @IBOutlet weak var scrollView: UIScrollView!
     @IBOutlet weak var insideScrollView: UIView!
     
     @IBOutlet weak var basicView: UIView!
     @IBOutlet weak var hotelIdLabel: UILabel!
     @IBOutlet weak var hotelIDTF: UITextField!
     @IBOutlet weak var hotelnameLabel: UILabel!
     @IBOutlet weak var hotelNameTF: UITextField!
     @IBOutlet weak var cityLabel: UILabel!
     @IBOutlet weak var cityTF: UITextField!
     @IBOutlet weak var availableSwitch: UISwitch!
     @IBOutlet weak var availableLabel: UILabel!
     @IBOutlet weak var hotelTypeLabel: UILabel!
     @IBOutlet weak var hotelTypeButton: UIButton!
     @IBOutlet weak var starRatingLabel: UILabel!
     @IBOutlet weak var starRatingButton: UIButton!
     @IBOutlet weak var hotelChainLabel: UILabel!
     @IBOutlet weak var enterChainNameIfAvailableTF: UITextField!
     
     @IBOutlet weak var locationView: UIView!
     @IBOutlet weak var countryTitleLabel: UILabel!
     @IBOutlet weak var countryTF: UITextField!
     @IBOutlet weak var stateOrProvinceTitleLabel: UILabel!
     @IBOutlet weak var stateOrProvinceTF: UITextField!
     @IBOutlet weak var addressLineOneTitleLabel: UILabel!
     @IBOutlet weak var addressLineOneTF: UITextField!
     @IBOutlet weak var addressLineTwoLabel: UILabel!
     @IBOutlet weak var addressLineTwoTF: UITextField!
     @IBOutlet weak var postalCodeLabel: UILabel!
     @IBOutlet weak var postalCodeTF: UITextField!
     @IBOutlet weak var latitudeLabel: UILabel!
     @IBOutlet weak var latitudeTF: UITextField!
     @IBOutlet weak var longitudeLabel: UILabel!
     @IBOutlet weak var longitudeTF: UITextField!
     @IBOutlet weak var emailLabel: UILabel!
     @IBOutlet weak var emailTF: UITextField!
     @IBOutlet weak var primaryPhoneLabel: UILabel!
     @IBOutlet weak var primaryPhoneTF: UITextField!
     @IBOutlet weak var websiteURLLabel: UILabel!
     @IBOutlet weak var websiteURLTF: UITextField!
     @IBOutlet weak var logoURLLabel: UILabel!
     @IBOutlet weak var logoURLTF: UITextField!
     @IBOutlet weak var coverImgURLLabel: UILabel!
     @IBOutlet weak var coverImgURLTF: UITextField!
     
     @IBOutlet weak var descriptionView: UIView!
     @IBOutlet weak var checkInTimeLabel: UILabel!
     @IBOutlet weak var checkInTimeTF: UITextField!
     @IBOutlet weak var checkOutTimeLabel: UILabel!
     @IBOutlet weak var checkOutTimeTF: UITextField!
     @IBOutlet weak var fullDescriptionLabel: UILabel!
     @IBOutlet weak var fulldescriptionTF: UITextView!
     @IBOutlet weak var acceptedCurrenciesLabel: UILabel!
     @IBOutlet weak var acceptedCurrenciesButton: UIButton!
     @IBOutlet weak var languageSpokenLabel: UILabel!
     @IBOutlet weak var languageSpokenButton: UIButton!
     @IBOutlet weak var covidSafetyLevelLabel: UILabel!
     @IBOutlet weak var covidSafetyLevelButton: UIButton!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         showBasic()
     }

     @IBAction func basicButtonAction(_ sender: Any) {
         showBasic()
     }
     
     @IBAction func locationButtonAction(_ sender: Any) {
         showLocation()
     }
     
     @IBAction func descriptionbuttonAction(_ sender: Any) {
         showDescription()
     }
     
     @IBAction func cancelbuttonAction(_ sender: Any) {
         self.dismiss(animated: true)
     }
     
     @IBAction func saveButtonAction(_ sender: Any) {
     }
     
     @IBAction func publishButtonAction(_ sender: Any) {
     }
     
 }


 extension UpdateHotelDetailsVC {
     func showBasic() {
         basicView.isHidden = false
         locationView.isHidden = true
         descriptionView.isHidden = true
     }

     func showLocation() {
         basicView.isHidden = true
         locationView.isHidden = false
         descriptionView.isHidden = true
     }

     func showDescription() {
         basicView.isHidden = true
         locationView.isHidden = true
         descriptionView.isHidden = false
     }
 }

 */

import UIKit

class UpdateHotelDetailsVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var updateHotelDetailsTitleLabel: UILabel!
    @IBOutlet weak var basicLineView: UIView!
    @IBOutlet weak var basicButton: UIButton!
    @IBOutlet weak var locationLineView: UIView!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var descriptionLineView: UIView!
    @IBOutlet weak var descriptionButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var cancelbutton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var publishButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    
    private var currentVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = storyboard?.instantiateViewController(withIdentifier: "BasicVC") as! BasicVC
        showChildVC(vc)
    }
    
    func showChildVC(_ vc: UIViewController) {
        currentVC?.willMove(toParent: nil)
        currentVC?.view.removeFromSuperview()
        currentVC?.removeFromParent()
        addChild(vc)
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        insideScrollView.addSubview(vc.view)

        NSLayoutConstraint.activate([
            vc.view.topAnchor.constraint(equalTo: insideScrollView.topAnchor),
            vc.view.bottomAnchor.constraint(equalTo: insideScrollView.bottomAnchor),
            vc.view.leadingAnchor.constraint(equalTo: insideScrollView.leadingAnchor),
            vc.view.trailingAnchor.constraint(equalTo: insideScrollView.trailingAnchor)
        ])
        vc.didMove(toParent: self)
        currentVC = vc
    }

    @IBAction func basicButtonAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BasicVC") as! BasicVC
        showChildVC(vc)
    }
    
    @IBAction func locationButtonAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
        showChildVC(vc)
    }
    
    @IBAction func descriptionbuttonAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DescriptionVC") as! DescriptionVC
        showChildVC(vc)
    }
    
    @IBAction func cancelbuttonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }
    
    @IBAction func publishButtonAction(_ sender: Any) {
    }
    
}
