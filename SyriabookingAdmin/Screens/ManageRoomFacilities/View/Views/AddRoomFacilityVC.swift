//
//  AddRoomFacilityVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 09/09/26.
//

import UIKit

class AddRoomFacilityVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var plusIconImgView: UIImageView!
    @IBOutlet weak var addRoomFacilityLabel: UILabel!
    @IBOutlet weak var facilityLabel: UILabel!
    @IBOutlet weak var facilityTypeButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }
}


extension AddRoomFacilityVC {
    func setUpUI() {
        plusIconImgView.tintColor = ThemeManager.shared.currentColor
        setupRoomFacilitiesTypeMenu()
    }
    
    func setupRoomFacilitiesTypeMenu() {
        let roomFacilities = ["Free Wi-Fi", "Wired Internet", "Internet in all areas","Non-smoking rooms", "Flat-screen TV", "Soundproof Rooms","Room Service", "Breakfast Included", "Breakfast Available (Paid)","Special Diet Menus", "Kid Meals", "Hot Tub","Steam Room", "Private Check-in/out", "Late Check-out","Daily Housekeeping", "Laundry", "Dry Cleaning","Ironing Service", "Meeting Facilities", "Disabled Facilities","Elevator", "Kids TV Channels", "Fax/Photocopy","Family Rooms", "Air Conditioning", "Safe Deposit Box", "Triple"]
        let actions = roomFacilities.map { types in
            UIAction(title: types) { [weak self] _ in
                self?.facilityTypeButton.setTitle(types, for: .normal)
            }
        }
        facilityTypeButton.menu = UIMenu(children: actions)
        facilityTypeButton.showsMenuAsPrimaryAction = true
    }
}
