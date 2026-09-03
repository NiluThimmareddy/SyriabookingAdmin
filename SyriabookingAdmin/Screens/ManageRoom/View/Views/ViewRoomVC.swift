//
//  ViewRoomVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 02/09/26.
//

import UIKit

class ViewRoomVC: UIViewController {

    @IBOutlet weak var eyeIconImgView: UIImageView!
    @IBOutlet weak var viewRoomIDLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var basicInfoView: UIView!
    @IBOutlet weak var basicInfoButton: UIButton!
    @IBOutlet weak var occupancyView: UIView!
    @IBOutlet weak var occupancyButton: UIButton!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var imagesButton: UIButton!
    @IBOutlet weak var ratebutton: UIButton!
    @IBOutlet weak var facilitiesButton: UIButton!

    private var currentVC: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    @IBAction func basicInfoButtonAction(_ sender: UIButton) {
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

    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func editButtonAction(_ sender: Any) {
    }

    @IBAction func deleteButtonAction(_ sender: Any) {
    }

    @IBAction func imagesButtonAction(_ sender: Any) {
    }

    @IBAction func rateButtonAction(_ sender: Any) {
    }

    @IBAction func facilitiesButtonAction(_ sender: Any) {
    }
}

extension ViewRoomVC {
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
