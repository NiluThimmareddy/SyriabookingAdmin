//
//  AddLandMarkVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 27/08/26.
//

import UIKit

class AddLandMarkVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var addLandmarkIconImgView: UIImageView!
    @IBOutlet weak var addLandmarkLabel: UILabel!
    @IBOutlet weak var landmarkNameLabel: UILabel!
    @IBOutlet weak var landmarkNameTF: UITextField!
    @IBOutlet weak var landmarkTypeLabel: UILabel!
    @IBOutlet weak var landmarkTypeButton: UIButton!
    @IBOutlet weak var distanceKMLabel: UILabel!
    @IBOutlet weak var distanceKMTF: UITextField!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }
    
}


extension AddLandMarkVC {
    func setUpUI() {
        addLandmarkIconImgView.tintColor = ThemeManager.shared.currentColor
        setupLandmarkTypeMenu()
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
}
