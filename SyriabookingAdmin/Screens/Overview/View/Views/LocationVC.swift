//
//  LocationVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 21/07/26.
//

import UIKit

class LocationVC: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
