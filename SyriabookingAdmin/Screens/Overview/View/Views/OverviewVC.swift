//
//  OverviewVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 14/07/26.
//

import UIKit

class OverviewVC: UIViewController {

    @IBOutlet weak var leftMenuButton: UIBarButtonItem!
    @IBOutlet weak var colourChangeButton: UIBarButtonItem!
    @IBOutlet weak var rightMenuButton: UIBarButtonItem!
    
    var leftMenuVC: LeftmenuVC?
    var isLeftMenuVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.applyGreenNavigationBar()
    }

    @IBAction func leftMenuButtonAction(_ sender: UIBarButtonItem) {
        
        sender.isEnabled = false
        
        if isLeftMenuVisible {
            closeLeftMenu()
            sender.isEnabled = true
            return
        }
        
        let storyboard = UIStoryboard(name: "Leftmenu", bundle: nil)
        guard let menuVC = storyboard.instantiateViewController(withIdentifier: "LeftmenuVC") as? LeftmenuVC else {
            sender.isEnabled = true
            return
        }
        
        leftMenuVC = menuVC
        
        menuVC.onDismiss = { [weak self] in
            self?.closeLeftMenu()
        }
        
        addChild(menuVC)
        view.addSubview(menuVC.view)
        
        menuVC.view.frame = CGRect(x: -view.frame.width,y: 0,
            width: view.frame.width,
            height: view.frame.height
        )
        
        menuVC.didMove(toParent: self)
        
        UIView.animate(withDuration: 0.3) {
            menuVC.view.frame.origin.x = 0
        } completion: { _ in
            self.isLeftMenuVisible = true
            sender.image = UIImage(systemName: "xmark")
            sender.isEnabled = true
        }
    }
    
    @IBAction func colourChangeButtonAction(_ sender: Any) {
    }
    
    @IBAction func rightMenuButtonAction(_ sender: Any) {
    }
}


extension OverviewVC {
    private func closeLeftMenu() {
        guard let menuVC = leftMenuVC else { return }
        
        UIView.animate(withDuration: 0.3) {
            menuVC.view.frame.origin.x = -self.view.frame.width
        } completion: { _ in
            menuVC.willMove(toParent: nil)
            menuVC.view.removeFromSuperview()
            menuVC.removeFromParent()
            
            self.leftMenuVC = nil
            self.isLeftMenuVisible = false
            
            self.leftMenuButton.image = UIImage(systemName: "line.3.horizontal")
            self.leftMenuButton.isEnabled = true
        }
    }
}
