//
//  ViewLandMarkVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 27/08/26.
//

import UIKit

class ViewLandMarkVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var viewLandmarkIconImgView: UIImageView!
    @IBOutlet weak var viewLandMarkLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var landmarkNameLabel: UILabel!
    @IBOutlet weak var landmarkNameTF: UITextField!
    @IBOutlet weak var landmarkTypeLabel: UILabel!
    @IBOutlet weak var landmarkTypeButton: UIButton!
    @IBOutlet weak var distanceKMLabel: UILabel!
    @IBOutlet weak var distanceKMTF: UITextField!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    var landmark: LandmarkModel?
    var onDismiss: (() -> Void)?
    
    private var isEditingLandmark = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        onDismiss?()
        dismiss(animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        if isEditingLandmark {
            saveLandmark()
        } else {
            setupEditMode()
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
    }
}


extension ViewLandMarkVC {
    func setUpUI() {
        viewLandmarkIconImgView.tintColor = ThemeManager.shared.currentColor
        setupLandmarkTypeMenu()
        setupViewMode()
        configureLandmarkData()
    }
    
    func setupLandmarkTypeMenu() {
        let type = ["Airport","Metro","TrainStation","BusStop","Beach","Park","Museum","ShoppingMall","Hospital",
                    "University","TouristSpot","Stadium"]
        let actions = type.map { types in
            UIAction(title: types) { [weak self] _ in
                self?.landmarkTypeButton.setTitle(types, for: .normal)
            }
        }
        landmarkTypeButton.menu = UIMenu(children: actions)
        landmarkTypeButton.showsMenuAsPrimaryAction = true
    }
    
    private func configureLandmarkData() {
        guard let landmarks = landmark else {
            return
        }
        idTF.text = landmarks.id
        landmarkNameTF.text = landmarks.name
        landmarkTypeButton.setTitle(landmarks.type, for: .normal)
        distanceKMTF.text = "\(landmarks.distance)"
        
        activeSwitch.isOn = landmarks.isActive
    }
    
    private func setupViewMode() {
        isEditingLandmark = false
        idTF.isUserInteractionEnabled = false
        landmarkNameTF.isUserInteractionEnabled = false
        distanceKMTF.isUserInteractionEnabled = false
        landmarkTypeButton.isUserInteractionEnabled = false
        activeSwitch.isUserInteractionEnabled = false
        deleteButton.isHidden = false
        editButton.isHidden = false
        editButton.setTitle("Edit", for: .normal)
        viewLandmarkIconImgView.image = UIImage(systemName: "eye")
        viewLandMarkLabel.text = "View Landmark"
    }
    
    private func setupEditMode() {
        isEditingLandmark = true
        idTF.isUserInteractionEnabled = true
        landmarkNameTF.isUserInteractionEnabled = true
        distanceKMTF.isUserInteractionEnabled = true
        landmarkTypeButton.isUserInteractionEnabled = true
        activeSwitch.isUserInteractionEnabled = true
        deleteButton.isHidden = true
        closeButton.tintColor = UIColor(hex: "DD2525")
        editButton.setTitle("Save", for: .normal)
        viewLandmarkIconImgView.image = UIImage(named: "ic_edit")
        viewLandMarkLabel.text = "Edit Landmark"
    }
    
    private func saveLandmark() {
        let id = idTF.text ?? ""
        let name = landmarkNameTF.text ?? ""
        let type = landmarkTypeButton.title(for: .normal) ?? ""
        let value = Double(distanceKMTF.text ?? "") ?? 0.0
        landmark = LandmarkModel(
            id: id,
            name: name,
            type: type,
            distance: value,
            isActive: activeSwitch.isOn,
        )
        setupViewMode()
    }
}

