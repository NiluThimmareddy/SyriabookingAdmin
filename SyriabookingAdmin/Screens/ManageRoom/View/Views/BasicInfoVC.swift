//
//  BasicInfoVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 03/09/26.
//

import UIKit

class BasicInfoVC: UIViewController {

    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var roomTypeButton: UIButton!
    @IBOutlet weak var bedTypeLabel: UILabel!
    @IBOutlet weak var bedTypeButton: UIButton!
    @IBOutlet weak var roomStatusLabel: UILabel!
    @IBOutlet weak var roomStatusButton: UIButton!
    @IBOutlet weak var refundPolicyLabel: UILabel!
    @IBOutlet weak var refundPolicyTF: UITextField!
    @IBOutlet weak var breakFastSwitch: UISwitch!
    @IBOutlet weak var breakFastIncludedLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRoomTypeMenu()
        setupBedTypeMenu()
        setupRoomStatusMenu()
    }
    
    func setupRoomTypeMenu() {
        let roomType = ["Deluxe","Standard Room","Suite","Executive Suite","Single Room","Double Room",
                    "Twin Room","Triple Room","Studio Room","Junior Suite","Presidential Suite","Balcony Room",
                    "Pet-Friendly Room","Four Bed","Deluxe suite","VIP Room","Double Room(Higher Floor)","Superior Room",
                    "Two-Bedroom Suite","Executive Corner Suite","Diplomatic Suite","Classic Room","single (sea view)",
                    "Double (sea view)","Junior suit (sea view)","Suite Duplex","Royal Suite","king(Sea view)",
                    "Honey moon room","Junior Suite (Sea View)","Executive Suite (Sea View)","King (City view)",
                    "Double (City view)","Triple (City view)","Four Bed (Sea View)","Bar Suite (City view)",
                    "Family Suite (City view)","Premium Room","Executive Suite (Vip)","Executive Suite (Royal)",
                    "Deluxe Chalet","Premium Chalet","Junior Chalet","Executive Chalet","Deluxe room (Back View)",
                    "Premium room (Back View)","Junior suite (back View)","Connecting Room","Connecting Room (Sea View)",
                    "Triple Room (Side Sea View)","Double Room (Side Sea View)","Single Room (Side Sea View)",
                    "Junior Suite (Side Sea View)","Royal Suite (sea View)","Family Suite"]
        let actions = roomType.map { types in
            UIAction(title: types) { [weak self] _ in
                self?.roomTypeButton.setTitle(types, for: .normal)
            }
        }
        roomTypeButton.menu = UIMenu(children: actions)
        roomTypeButton.showsMenuAsPrimaryAction = true
    }

    func setupBedTypeMenu() {
        let bedType = ["Single","Double","Queen","King","Twin","Bunk","King","Twin","Bunk","SofaBed","Murphy","Futon"]
        let actions = bedType.map { types in
            UIAction(title: types) { [weak self] _ in
                self?.bedTypeButton.setTitle(types, for: .normal)
            }
        }
        bedTypeButton.menu = UIMenu(children: actions)
        bedTypeButton.showsMenuAsPrimaryAction = true
    }
    
    func setupRoomStatusMenu() {
        let roomStatus = ["Available","Inactive","Occupied","UnderMaintenance","OutOfService","Reserved"]
        let actions = roomStatus.map { types in
            UIAction(title: types) { [weak self] _ in
                self?.roomStatusButton.setTitle(types, for: .normal)
            }
        }
        roomStatusButton.menu = UIMenu(children: actions)
        roomStatusButton.showsMenuAsPrimaryAction = true
    }
    
}
