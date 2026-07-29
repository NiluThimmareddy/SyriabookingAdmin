//
//  BaseViewController.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 23/07/26.
//

import UIKit

class BaseViewController: UIViewController {
    
    var leftMenuVC: LeftmenuVC?
    var isLeftMenuVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        
        navigationController?.applyTheme()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateTheme),
            name: .themeChanged,
            object: nil
        )
    }
    
    @objc func updateTheme() {
        navigationController?.applyTheme()
    }
    
    
    @objc private func themeChanged() {
        navigationController?.applyTheme()
    }
    
    func openThemePicker() {
        
        let vc = ThemeColorPickerVC()
        
        vc.modalPresentationStyle = .overCurrentContext
//        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: false)

    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
            self.navigationItem.leftBarButtonItem?.image =
            UIImage(systemName: "xmark")
            sender.isEnabled = true
        }
    }
    
    @IBAction func colourChangeButtonAction(_ sender: Any) {
        openThemePicker()
    }
    
    @IBAction func rightMenuButtonAction(_ sender: Any) {
        
        let alert = UIAlertController(title: nil,message: nil,preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive) { _ in
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            guard let loginVC = storyboard.instantiateViewController(
                withIdentifier: "LoginVC"
            ) as? LoginVC else {
                return
            }
            self.navigationController?.setViewControllers([loginVC],animated: true)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // iPad support
        if let popover = alert.popoverPresentationController {
            popover.barButtonItem = navigationItem.rightBarButtonItems?.first
        }
        present(alert, animated: true)
    }
}

extension BaseViewController {
    
    private func setupNavigationBar() {
        
        let leftButton = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain,
            target: self,
            action: #selector(leftMenuTapped)
        )
        
        let bookingLabel = UILabel()
        bookingLabel.text = "Booking Admin"
        bookingLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        bookingLabel.textColor = .white
        
        let bookingLabelItem = UIBarButtonItem(customView: bookingLabel)
        
        navigationItem.leftBarButtonItems = [
            leftButton,
            bookingLabelItem
        ]
        
        let colorButton = UIBarButtonItem(
            image: UIImage(named: "ic_edit"),
            style: .plain,
            target: self,
            action: #selector(colorTapped)
        )
        
        let rightButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain,
            target: self,
            action: #selector(rightMenuTapped)
        )
        
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItems = [rightButton, colorButton]
    }
    
    @objc func leftMenuTapped() {
        guard let button = navigationItem.leftBarButtonItem else { return }
        leftMenuButtonAction(button)
    }
    
    @objc func colorTapped() {
        colourChangeButtonAction(self)
    }
    
    @objc func rightMenuTapped() {
        rightMenuButtonAction(self)
    }
    
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
            
            self.navigationItem.leftBarButtonItem?.image =
            UIImage(systemName: "line.3.horizontal")
            
            self.navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }
    
}


