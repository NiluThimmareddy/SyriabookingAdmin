//
//  ViewDiscountVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 24/08/26.
//

import UIKit

class ViewDiscountVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var viewDiscountLabel: UILabel!
    @IBOutlet weak var discountIdLabel: UILabel!
    @IBOutlet weak var discountIdTF: UITextField!
    @IBOutlet weak var discountNameLabel: UILabel!
    @IBOutlet weak var discountNameTF: UITextField!
    @IBOutlet weak var discountTypeLabel: UILabel!
    @IBOutlet weak var discountTypeButton: UIButton!
    @IBOutlet weak var discountValueLabel: UILabel!
    @IBOutlet weak var discountValueTF: UITextField!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var discount: DiscountModel?
    var onDismiss: (() -> Void)?
    
    private var isEditingDiscount = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        onDismiss?()
        dismiss(animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: UIButton) {
        if isEditingDiscount {
            saveDiscount()
        } else {
            setupEditMode()
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
    }
    
}

extension ViewDiscountVC {
    func setUpUI() {
        setupDiscountTypeMenu()
        setupViewMode()
        configureDiscountData()
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
    
    private func configureDiscountData() {
        guard let discount = discount else {
            return
        }
        discountIdTF.text = discount.id
        discountNameTF.text = discount.name
        discountTypeButton.setTitle(discount.type, for: .normal)
        discountValueTF.text = "\(discount.value)"
        
        activeSwitch.isOn = discount.isActive
    }
    
    private func setupViewMode() {
        isEditingDiscount = false
        discountIdTF.isUserInteractionEnabled = false
        discountNameTF.isUserInteractionEnabled = false
        discountValueTF.isUserInteractionEnabled = false
        discountTypeButton.isUserInteractionEnabled = false
        activeSwitch.isUserInteractionEnabled = false
        deleteButton.isHidden = false
        editButton.isHidden = false
        editButton.setTitle("Edit", for: .normal)
        iconImgView.image = UIImage(systemName: "eye")
        viewDiscountLabel.text = "View Discount"
    }
    
    private func setupEditMode() {
        isEditingDiscount = true
        discountIdTF.isUserInteractionEnabled = true
        discountNameTF.isUserInteractionEnabled = true
        discountValueTF.isUserInteractionEnabled = true
        discountTypeButton.isUserInteractionEnabled = true
        activeSwitch.isUserInteractionEnabled = true
        deleteButton.isHidden = true
        editButton.setTitle("Save", for: .normal)
        iconImgView.image = UIImage(named: "ic_edit")
        viewDiscountLabel.text = "Edit Discount"
    }
    
    private func saveDiscount() {
        let id = discountIdTF.text ?? ""
        let name = discountNameTF.text ?? ""
        let type = discountTypeButton.title(for: .normal) ?? "Percentage"
        let value = Double(discountValueTF.text ?? "") ?? 0.0
        discount = DiscountModel(
            id: id,
            name: name,
            type: type,
            value: value,
            isActive: activeSwitch.isOn,
            activeDate: discount?.activeDate
        )
        setupViewMode()
    }
}

