//
//  AddNewFacilityVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 25/08/26.
//

import UIKit

class AddNewFacilityVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var addNewFacilityLabel: UILabel!
    @IBOutlet weak var facilityLabel: UILabel!
    @IBOutlet weak var facilitiesButton: UIButton!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var notesTF: UITextField!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addNewFacilityIconImageView: UIImageView!
    
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

extension AddNewFacilityVC {
    func setUpUI() {
        addNewFacilityIconImageView.tintColor = ThemeManager.shared.currentColor
        setupFacilitiesTypeMenu()
    }
    
    func setupFacilitiesTypeMenu() {
        let type = ["Outdoor Pool","Indoor Pool","Free Parking","Valet Parking","EV Charging","Free Airport Shuttle",
            "Paid Airport Shuttle","Car Rental","Restaurant","Coffee Shop","Snack Bar","Vending Machines","Spa",
            "Sauna","Steam Room","Gym","Salon","24h Front Desk","Concierge","Tour Desk","Luggage Storage",
            "Currency Exchange","Business Center","Meeting Facilities"
        ]
        let actions = type.map { types in
            UIAction(title: types) { [weak self] _ in
                self?.facilitiesButton.setTitle(types, for: .normal)
            }
        }
        facilitiesButton.menu = UIMenu(children: actions)
        facilitiesButton.showsMenuAsPrimaryAction = true
    }
}
