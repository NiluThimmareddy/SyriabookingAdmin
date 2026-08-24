//
//  AddDiscountVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 24/08/26.
//

import UIKit

class AddDiscountVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var addDiscountLabel: UILabel!
    @IBOutlet weak var discountNameLabel: UILabel!
    @IBOutlet weak var discountNameTF: UITextField!
    @IBOutlet weak var discountTypeLabel: UILabel!
    @IBOutlet weak var discountTypeButton: UIButton!
    @IBOutlet weak var discountValueLabel: UILabel!
    @IBOutlet weak var discountValueTF: UITextField!
    @IBOutlet weak var activeSwitch: UISwitch!
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

extension AddDiscountVC {
    func setUpUI() {
        setupDiscountTypeMenu()
    }
    
    func setupDiscountTypeMenu() {
        let type = ["Percentage","Fixed"]
        let actions = type.map { types in
            UIAction(title: types) { [weak self] _ in
                self?.discountTypeButton.setTitle(types, for: .normal)
            }
        }
        discountTypeButton.menu = UIMenu(children: actions)
        discountTypeButton.showsMenuAsPrimaryAction = true
    }
}
