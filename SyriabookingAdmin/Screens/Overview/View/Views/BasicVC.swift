//
//  BasicVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 21/07/26.
//

import UIKit

class BasicVC: UIViewController {
    
    @IBOutlet weak var basicView: UIView!
    @IBOutlet weak var hotelIdLabel: UILabel!
    @IBOutlet weak var hotelIDTF: UITextField!
    @IBOutlet weak var hotelnameLabel: UILabel!
    @IBOutlet weak var hotelNameTF: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var availableSwitch: UISwitch!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var hotelTypeLabel: UILabel!
    @IBOutlet weak var hotelTypeButton: UIButton!
    @IBOutlet weak var starRatingLabel: UILabel!
    @IBOutlet weak var starRatingButton: UIButton!
    @IBOutlet weak var hotelChainLabel: UILabel!
    @IBOutlet weak var enterChainNameIfAvailableTF: UITextField!
    
    let hotelTypes = ["Hotel","Resort","Motel","Hostel","BedAndBreakfast","Apartment"]
    let starRatings = ["1 Star","2 Star","3 Star","4 Star","5 Star"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHotelTypeMenu()
        setupStarRatingMenu()
    }

    func setupHotelTypeMenu() {

        let actions = hotelTypes.map { type in
            UIAction(title: type) { [weak self] _ in
                self?.hotelTypeButton.setTitle(type, for: .normal)
            }
        }

        hotelTypeButton.menu = UIMenu(children: actions)
        hotelTypeButton.showsMenuAsPrimaryAction = true
    }
    
    func setupStarRatingMenu() {

        let actions = starRatings.map { rating in
            UIAction(title: rating) { [weak self] _ in
                self?.starRatingButton.setTitle(rating, for: .normal)
            }
        }

        starRatingButton.menu = UIMenu(children: actions)
        starRatingButton.showsMenuAsPrimaryAction = true
    }
}
