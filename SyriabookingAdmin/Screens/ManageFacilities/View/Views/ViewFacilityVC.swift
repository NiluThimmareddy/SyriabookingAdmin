//
//  ViewFacilityVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 25/08/26.
//

import UIKit

class ViewFacilityVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var facilityTitleLabel: UILabel!
    @IBOutlet weak var discountIdLabel: UILabel!
    @IBOutlet weak var discountIdTF: UITextField!
    @IBOutlet weak var facilityLabel: UILabel!
    @IBOutlet weak var facilitiesButton: UIButton!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var noteTF: UITextField!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deletebutton: UIButton!
    @IBOutlet weak var viewFacilityIconImageView: UIImageView!
    
    var facility: FacilityModel?
    var onDismiss: (() -> Void)?
    
    private var isEditingFacilities = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        onDismiss?()
        dismiss(animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        if isEditingFacilities {
            saveFacilities()
        } else {
            setupEditMode()
        }
    }
    
    @IBAction func deletebuttonAction(_ sender: Any) {
    }
    
}

extension ViewFacilityVC {
    func setUpUI() {
        viewFacilityIconImageView.tintColor = ThemeManager.shared.currentColor
        setupFacilitiesTypeMenu()
        setupViewMode()
        configureFacilitiesData()
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
    
    private func configureFacilitiesData() {
        guard let facility = facility else {
            return
        }
        discountIdTF.text = facility.id
        noteTF.text = facility.notes
        facilitiesButton.setTitle(facility.facility, for: .normal)
        
        activeSwitch.isOn = facility.isActive
    }
    
    private func setupViewMode() {
        isEditingFacilities = false
        discountIdTF.isUserInteractionEnabled = false
        noteTF.isUserInteractionEnabled = false
        facilitiesButton.isUserInteractionEnabled = false
        activeSwitch.isUserInteractionEnabled = false
        deletebutton.isHidden = false
        editButton.isHidden = false
        editButton.setTitle("Edit", for: .normal)
        iconImgView.image = UIImage(systemName: "eye")
        facilityTitleLabel.text = "View Facility"
    }
    
    private func setupEditMode() {
        isEditingFacilities = true
        discountIdTF.isUserInteractionEnabled = true
        noteTF.isUserInteractionEnabled = true
        facilitiesButton.isUserInteractionEnabled = true
        activeSwitch.isUserInteractionEnabled = true
        deletebutton.isHidden = true
        editButton.setTitle("Save", for: .normal)
        iconImgView.image = UIImage(named: "ic_edit")
        facilityTitleLabel.text = "Update Facility"
    }
    
    private func saveFacilities() {
        let id = discountIdTF.text ?? ""
        let note = noteTF.text ?? ""
        let facilities = facilitiesButton.title(for: .normal) ?? ""
        facility = FacilityModel(
            id: id,
            facility: facilities,
            notes: note,
            isActive: activeSwitch.isOn,
        )
        setupViewMode()
    }
}
