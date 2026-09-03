//
//  DetailsVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 03/09/26.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var roomSizeLabel: UILabel!
    @IBOutlet weak var roomSizeTF: UITextField!
    @IBOutlet weak var basePriceLabel: UILabel!
    @IBOutlet weak var basePriceTF: UITextField!
    @IBOutlet weak var increaseBasePriceButton: UIButton!
    @IBOutlet weak var decreaseBasePriceButton: UIButton!
    @IBOutlet weak var amenitiesLabel: UILabel!
    @IBOutlet weak var amenitiesButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTF: UITextField!
    
    var basePriceCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAmenitiesMenu()
        basePriceTF.text = "\(basePriceCount)"
    }

    func setupAmenitiesMenu() {
        let amenities = ["Wifi","AirConditioning","Heater","MiniBar","Television","Safe","CoffeeMaker","HairDryer","RoomService","Balcony","WorkDesk","Iron","RoomService","Balcony","WorkDesk","Iron","ExtraPillows","BathTub"]
        let actions = amenities.map { types in
            UIAction(title: types) { [weak self] _ in
                self?.amenitiesButton.setTitle(types, for: .normal)
            }
        }
        amenitiesButton.menu = UIMenu(children: actions)
        amenitiesButton.showsMenuAsPrimaryAction = true
    }
    
    @IBAction func increaseBasePriceButtonAction(_ sender: Any) {
        basePriceCount += 1
        basePriceTF.text = "\(basePriceCount)"
    }
    
    @IBAction func decreaseBasePriceButtonAction(_ sender: Any) {
        if basePriceCount > 0 {
            basePriceCount -= 1
            basePriceTF.text = "\(basePriceCount)"
        }
    }
    
}
