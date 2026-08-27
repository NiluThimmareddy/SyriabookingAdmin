//
//  UpdateHotelDetailsVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 21/07/26.
//

import UIKit

class UpdateHotelDetailsVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var updateHotelDetailsTitleLabel: UILabel!
    @IBOutlet weak var basicLineView: UIView!
    @IBOutlet weak var basicButton: UIButton!
    @IBOutlet weak var locationLineView: UIView!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var descriptionLineView: UIView!
    @IBOutlet weak var descriptionButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var cancelbutton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var publishButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    
    private var currentVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        publishButton.applyOverviewGradient(color: ThemeManager.shared.currentColor)
        updateTabSelection(selectedButton: basicButton)
        let vc = storyboard?.instantiateViewController(withIdentifier: "BasicVC") as! BasicVC
        showChildVC(vc)
        
//        basicLineView.backgroundColor = ThemeManager.shared.currentColor
//        descriptionLineView.backgroundColor = ThemeManager.shared.currentColor
//        locationLineView.backgroundColor = ThemeManager.shared.currentColor
    }
    
    func updateTabSelection(selectedButton: UIButton) {
        
        let selectedColor = ThemeManager.shared.currentColor
        let normalColor = UIColor(hex: "#575757")
        
        let buttons = [basicButton, locationButton, descriptionButton]
        
        // Reset all buttons
        buttons.forEach { button in
            
            button?.setTitleColor(normalColor, for: .normal)
            
            if #available(iOS 15.0, *) {
                if var config = button?.configuration {
                    config.baseForegroundColor = normalColor
                    button?.configuration = config
                }
            }
        }
        
        // Selected button
        selectedButton.setTitleColor(selectedColor, for: .normal)
        
        if #available(iOS 15.0, *) {
            if var config = selectedButton.configuration {
                config.baseForegroundColor = selectedColor
                selectedButton.configuration = config
            }
        }
        
        // Hide all line views
        basicLineView.isHidden = true
        locationLineView.isHidden = true
        descriptionLineView.isHidden = true
        
        // Show selected line view
        switch selectedButton {
            
        case basicButton:
            basicLineView.isHidden = false
            basicLineView.backgroundColor = selectedColor
            
        case locationButton:
            locationLineView.isHidden = false
            locationLineView.backgroundColor = selectedColor
            
        case descriptionButton:
            descriptionLineView.isHidden = false
            descriptionLineView.backgroundColor = selectedColor
            
        default:
            break
        }
    }
    
    func showChildVC(_ vc: UIViewController) {
        currentVC?.willMove(toParent: nil)
        currentVC?.view.removeFromSuperview()
        currentVC?.removeFromParent()
        addChild(vc)
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        insideScrollView.addSubview(vc.view)

        NSLayoutConstraint.activate([
            vc.view.topAnchor.constraint(equalTo: insideScrollView.topAnchor),
            vc.view.bottomAnchor.constraint(equalTo: insideScrollView.bottomAnchor),
            vc.view.leadingAnchor.constraint(equalTo: insideScrollView.leadingAnchor),
            vc.view.trailingAnchor.constraint(equalTo: insideScrollView.trailingAnchor)
        ])
        vc.didMove(toParent: self)
        currentVC = vc
    }

    @IBAction func basicButtonAction(_ sender: UIButton) {
        updateTabSelection(selectedButton: sender)
        let vc = storyboard?.instantiateViewController(withIdentifier: "BasicVC") as! BasicVC
        showChildVC(vc)
    }

    @IBAction func locationButtonAction(_ sender: UIButton) {
        updateTabSelection(selectedButton: sender)
        let vc = storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
        showChildVC(vc)
    }

    @IBAction func descriptionbuttonAction(_ sender: UIButton) {
        updateTabSelection(selectedButton: sender)
        let vc = storyboard?.instantiateViewController(withIdentifier: "DescriptionVC") as! DescriptionVC
        showChildVC(vc)
    }
    
    @IBAction func cancelbuttonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }
    
    @IBAction func publishButtonAction(_ sender: Any) {
    }
    
}
