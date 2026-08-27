//
//  ViewPolicyVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 27/08/26.
//

import UIKit

class ViewPolicyVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var viewPolicyIconImgView: UIImageView!
    @IBOutlet weak var viewPolicyLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var policy: PolicyModel?
    var onDismiss: (() -> Void)?
    
    private var isEditingPolicy = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        onDismiss?()
        dismiss(animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        if isEditingPolicy {
            savePolicy()
        } else {
            setupEditMode()
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
    }
}


extension ViewPolicyVC {
    func setUpUI() {
        viewPolicyIconImgView.tintColor = ThemeManager.shared.currentColor
        setupViewMode()
        configureLandmarkData()
    }
    
    private func configureLandmarkData() {
        guard let policies = policy else {
            return
        }
        idTF.text = policies.id
        titleTF.text = policies.title
        descriptionTF.text = policies.description
        activeSwitch.isOn = policies.isActive
    }
    
    private func setupViewMode() {
        isEditingPolicy = false
        idTF.isUserInteractionEnabled = false
        titleTF.isUserInteractionEnabled = false
        descriptionTF.isUserInteractionEnabled = false
        activeSwitch.isUserInteractionEnabled = false
        deleteButton.isHidden = false
        editButton.isHidden = false
        editButton.setTitle("Edit", for: .normal)
        viewPolicyIconImgView.image = UIImage(systemName: "eye")
        viewPolicyLabel.text = "View Policy"
    }
    
    private func setupEditMode() {
        isEditingPolicy = true
        idTF.isUserInteractionEnabled = true
        titleTF.isUserInteractionEnabled = true
        descriptionTF.isUserInteractionEnabled = true
        activeSwitch.isUserInteractionEnabled = true
        deleteButton.isHidden = true
        closeButton.tintColor = UIColor(hex: "DD2525")
        editButton.setTitle("Save", for: .normal)
        viewPolicyIconImgView.image = UIImage(named: "ic_edit")
        viewPolicyLabel.text = "Update Policy"
    }
    
    private func savePolicy() {
        let id = idTF.text ?? ""
        let title = titleTF.text ?? ""
        let description = descriptionTF.text ?? ""
        policy = PolicyModel(
            id: id,
            title: title,
            description: description,
            isActive: activeSwitch.isOn,
        )
        setupViewMode()
    }
}

