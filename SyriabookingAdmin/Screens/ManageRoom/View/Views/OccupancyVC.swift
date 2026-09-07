//
//  OccupancyVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 03/09/26.
//

import UIKit

class OccupancyVC: UIViewController {

    @IBOutlet weak var maxAdultsLabel: UILabel!
    @IBOutlet weak var maxAdultsTF: UITextField!
    @IBOutlet weak var increaseAdultsButton: UIButton!
    @IBOutlet weak var decreaseAdultsButton: UIButton!
    @IBOutlet weak var maxChildrenLabel: UILabel!
    @IBOutlet weak var maxChildrenTF: UITextField!
    @IBOutlet weak var increaseChildrenButton: UIButton!
    @IBOutlet weak var decreaseChildrenButton: UIButton!
    @IBOutlet weak var availableRoomsLabel: UILabel!
    @IBOutlet weak var availableRoomsTF: UITextField!
    @IBOutlet weak var increaseAvailableRoomsButton: UIButton!
    @IBOutlet weak var decreaseAvailableRoomsButton: UIButton!
    @IBOutlet weak var inventoryLabel: UILabel!
    @IBOutlet weak var inventoryTF: UITextField!
    @IBOutlet weak var increaseInventoryButton: UIButton!
    @IBOutlet weak var decreaseInventoryButton: UIButton!

    var maxAdultsCount = 0
    var maxChildrenCount = 0
    var availableRoomsCount = 0
    var inventoryCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCounts()
    }

    private func setupCounts() {
        maxAdultsTF.text = "\(maxAdultsCount)"
        maxChildrenTF.text = "\(maxChildrenCount)"
        availableRoomsTF.text = "\(availableRoomsCount)"
        inventoryTF.text = "\(inventoryCount)"
    }

    @IBAction func increaseAdultsButtonAction(_ sender: Any) {
        maxAdultsCount += 1
        maxAdultsTF.text = "\(maxAdultsCount)"
    }

    @IBAction func decreaseAdultsButtonAction(_ sender: Any) {
        if maxAdultsCount > 0 {
            maxAdultsCount -= 1
            maxAdultsTF.text = "\(maxAdultsCount)"
        }
    }

    @IBAction func increaseChildrenButtonAction(_ sender: Any) {
        maxChildrenCount += 1
        maxChildrenTF.text = "\(maxChildrenCount)"
    }

    @IBAction func decreaseChildrenButtonAction(_ sender: Any) {
        if maxChildrenCount > 0 {
            maxChildrenCount -= 1
            maxChildrenTF.text = "\(maxChildrenCount)"
        }
    }

    @IBAction func increaseAvailableRoomsbuttonAction(_ sender: Any) {
        availableRoomsCount += 1
        availableRoomsTF.text = "\(availableRoomsCount)"
    }
    
    @IBAction func decreaseAvailableRoomsButtonAction(_ sender: Any) {
        if availableRoomsCount > 0 {
            availableRoomsCount -= 1
            availableRoomsTF.text = "\(availableRoomsCount)"
        }
    }

    @IBAction func increaseInventoryButtonAction(_ sender: Any) {
        inventoryCount += 1
        inventoryTF.text = "\(inventoryCount)"
    }

    @IBAction func decreaseInventorybuttonAction(_ sender: Any) {
        if inventoryCount > 0 {
            inventoryCount -= 1
            inventoryTF.text = "\(inventoryCount)"
        }
    }
}
