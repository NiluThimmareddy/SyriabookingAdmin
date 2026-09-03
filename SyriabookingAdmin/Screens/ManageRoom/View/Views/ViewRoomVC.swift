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
    @IBOutlet weak var basicInfoView: UIView!
    @IBOutlet weak var basicInfoButton: UIButton!
    @IBOutlet weak var occupancyView: UIView!
    @IBOutlet weak var occupancyButton: UIButton!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var imagesButton: UIButton!
    @IBOutlet weak var ratebutton: UIButton!
    @IBOutlet weak var facilitiesButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func basicInfoButtonAction(_ sender: Any) {
    }
    
    @IBAction func occupancyButtonAction(_ sender: Any) {
    }
    
    @IBAction func detailsButtonAction(_ sender: Any) {
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
