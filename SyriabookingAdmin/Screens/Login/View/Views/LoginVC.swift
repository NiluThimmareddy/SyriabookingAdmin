//
//  LoginVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 13/07/26.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var adminloginLabel: UILabel!
    @IBOutlet weak var pleaseEnterYourCredentialsLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailIDTF: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.applyLightShadow()
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Overview", bundle: nil).instantiateViewController(withIdentifier: "OverviewVC") as! OverviewVC
//        storyboard.modalPresentationStyle = .fullScreen
//        present(storyboard, animated: true)
        self.navigationController?.pushViewController(storyboard, animated: true)
    }

}
