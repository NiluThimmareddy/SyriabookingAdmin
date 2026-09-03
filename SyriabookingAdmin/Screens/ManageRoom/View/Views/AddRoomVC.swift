//
//  AddRoomVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 02/09/26.
//

import UIKit

class AddRoomVC: UIViewController {

    @IBOutlet weak var plusIconImgView: UIImageView!
    @IBOutlet weak var addNewRoomLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var basicInfoView: UIView!
    @IBOutlet weak var basicInfoButton: UIButton!
    @IBOutlet weak var occupancyView: UIView!
    @IBOutlet weak var occupancyButton: UIButton!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    private var currentVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func basicInfobuttonAction(_ sender: UIButton) {
        updateTabSelection(selectedButton: sender)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "BasicInfoVC") as? BasicInfoVC else {
            return
        }
        showChildVC(vc)
    }
    
    @IBAction func occupancyButtonAction(_ sender: UIButton) {
        updateTabSelection(selectedButton: sender)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "OccupancyVC") as? OccupancyVC else {
            return
        }
        showChildVC(vc)
    }
    
    @IBAction func detailsButtonAction(_ sender: UIButton) {
        updateTabSelection(selectedButton: sender)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsVC else {
            return
        }
        showChildVC(vc)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }
}

extension AddRoomVC {
    func setUpUI() {
        updateTabSelection(selectedButton: basicInfoButton)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "BasicInfoVC") as? BasicInfoVC else {
            return
        }
        showChildVC(vc)
    }
    
    func updateTabSelection(selectedButton: UIButton) {
        let selectedColor = ThemeManager.shared.currentColor
        let normalColor = UIColor(hex: "#575757")
        let buttons = [
            basicInfoButton,
            occupancyButton,
            detailsButton
        ]
        buttons.forEach { button in
            button?.setTitleColor(normalColor, for: .normal)
            if #available(iOS 15.0, *) {
                if var config = button?.configuration {
                    config.baseForegroundColor = normalColor
                    button?.configuration = config
                }
            }
        }

        selectedButton.setTitleColor(selectedColor, for: .normal)
        if #available(iOS 15.0, *) {
            if var config = selectedButton.configuration {
                config.baseForegroundColor = selectedColor
                selectedButton.configuration = config
            }
        }

        basicInfoView.isHidden = true
        occupancyView.isHidden = true
        detailsView.isHidden = true

        switch selectedButton {
        case basicInfoButton:
            basicInfoView.isHidden = false
            basicInfoView.backgroundColor = selectedColor
        case occupancyButton:
            occupancyView.isHidden = false
            occupancyView.backgroundColor = selectedColor
        case detailsButton:
            detailsView.isHidden = false
            detailsView.backgroundColor = selectedColor
        default:
            break
        }
    }

    private func showChildVC(_ vc: UIViewController) {

        currentVC?.willMove(toParent: nil)
        currentVC?.view.removeFromSuperview()
        currentVC?.removeFromParent()
        addChild(vc)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        insideScrollView.addSubview(vc.view)
        NSLayoutConstraint.activate([
            vc.view.topAnchor.constraint(
                equalTo: insideScrollView.topAnchor
            ),
            vc.view.bottomAnchor.constraint(
                equalTo: insideScrollView.bottomAnchor
            ),
            vc.view.leadingAnchor.constraint(
                equalTo: insideScrollView.leadingAnchor
            ),
            vc.view.trailingAnchor.constraint(
                equalTo: insideScrollView.trailingAnchor
            )
        ])
        vc.didMove(toParent: self)
        currentVC = vc
    }
}
