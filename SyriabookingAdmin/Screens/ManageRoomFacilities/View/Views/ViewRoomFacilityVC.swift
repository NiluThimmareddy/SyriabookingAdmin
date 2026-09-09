//
//  ViewRoomFacilityVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 09/09/26.
//

import UIKit

class ViewRoomFacilityVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var viewFacilityIconImgView: UIImageView!
    @IBOutlet weak var viewRoomFacilityLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var facilityTypeLabel: UILabel!
    @IBOutlet weak var facilityTypeButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var facility: RoomFacility?
    var onDismiss: (() -> Void)?
    
    private var isEditingRoomFacilities = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        onDismiss?()
        dismiss(animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        if isEditingRoomFacilities {
            saveFacilities()
        } else {
            setupEditMode()
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
    }
}

extension ViewRoomFacilityVC {
    func setUpUI() {
        viewFacilityIconImgView.tintColor = ThemeManager.shared.currentColor
        setupRoomFacilitiesTypeMenu()
        setupViewMode()
        configureRoomFacilitiesData()
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
    
    private func configureRoomFacilitiesData() {
        guard let facility = facility else {
            return
        }
        idTF.text = facility.id
        descriptionTF.text = facility.description
        facilityTypeButton.setTitle(facility.facility, for: .normal)
    }
    
    private func setupViewMode() {
        isEditingRoomFacilities = false
        idTF.isUserInteractionEnabled = false
        descriptionTF.isUserInteractionEnabled = false
        facilityTypeButton.isUserInteractionEnabled = false
        deleteButton.isHidden = false
        editButton.isHidden = false
        editButton.setTitle("Edit", for: .normal)
        viewFacilityIconImgView.image = UIImage(systemName: "eye")
        viewRoomFacilityLabel.text = "View Room Facility"
    }
    
    private func setupEditMode() {
        isEditingRoomFacilities = true
        idTF.isUserInteractionEnabled = true
        descriptionTF.isUserInteractionEnabled = true
        facilityTypeButton.isUserInteractionEnabled = true
        deleteButton.isHidden = true
        closeButton.tintColor = UIColor(hex: "DD2525")
        editButton.setTitle("Save", for: .normal)
        viewFacilityIconImgView.image = UIImage(named: "ic_edit")
        viewRoomFacilityLabel.text = "Update Room Facility"
    }
    
    private func saveFacilities() {
        let id = idTF.text ?? ""
        let description = descriptionTF.text ?? ""
        let facilities = facilityTypeButton.title(for: .normal) ?? ""
        facility = RoomFacility(
            id: id,
            facility: facilities,
            description: description
        )
        setupViewMode()
        closeButton.tintColor = UIColor(hex: "575757")
    }
}
