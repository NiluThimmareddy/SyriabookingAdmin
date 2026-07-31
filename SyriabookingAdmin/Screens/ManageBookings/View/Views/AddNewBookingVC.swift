//
//  AddNewBookingVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 31/07/26.
//

import UIKit

class AddNewBookingVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var newBookingsTitleLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var addUserButton: UIButton!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var roomTypeButton: UIButton!
    @IBOutlet weak var guestNameLabel: UILabel!
    @IBOutlet weak var guestNameTF: UITextField!
    @IBOutlet weak var guestPhoneLabel: UILabel!
    @IBOutlet weak var guestPhoneNoTF: UITextField!
    @IBOutlet weak var guestEmailLabel: UILabel!
    @IBOutlet weak var guestEmailTF: UITextField!
    @IBOutlet weak var guestsLabel: UILabel!
    @IBOutlet weak var noOfGuestsTF: UITextField!
    @IBOutlet weak var increaseGuestsCountButton: UIButton!
    @IBOutlet weak var decreaseGuestsCountButton: UIButton!
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var checkInDateTF: UITextField!
    @IBOutlet weak var checkInCalendarButton: UIButton!
    @IBOutlet weak var checkOutLabel: UILabel!
    @IBOutlet weak var checkOutDateTF: UITextField!
    @IBOutlet weak var checkOutCalendarButton: UIButton!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var totalAmountTF: UITextField!
    @IBOutlet weak var increaseTotalAmountButton: UIButton!
    @IBOutlet weak var decreaseTotalAmountButton: UIButton!
    @IBOutlet weak var totalDiscountLabel: UILabel!
    @IBOutlet weak var totalDiscountTF: UITextField!
    @IBOutlet weak var increaseTotalDiscountButton: UIButton!
    @IBOutlet weak var decreaseTotalDiscountButton: UIButton!
    @IBOutlet weak var netTotalLabel: UILabel!
    @IBOutlet weak var netTotalTF: UITextField!
    @IBOutlet weak var increaseNetTotalButton: UIButton!
    @IBOutlet weak var decreaseNetTotalButton: UIButton!
    @IBOutlet weak var BookingDetailsLabel: UILabel!
    @IBOutlet weak var bookingDetailsTF: UITextField!
    @IBOutlet weak var bookingTypeLabel: UILabel!
    @IBOutlet weak var bookingTypeButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var cancelbutton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUserMenu()
        setupRoomMenu()
        setupBookingTypeMenu()
        setupStatusMenu()
    }
    
    @IBAction func increaseGuestsCountButtonAction(_ sender: Any) {
    }
    
    @IBAction func decreaseGuestsCountButtonAction(_ sender: Any) {
    }
    
    @IBAction func checkInCalendarButtonAction(_ sender: Any) {
    }
    
    @IBAction func checkOutCalendarButtonAction(_ sender: Any) {
    }
    
    @IBAction func increaseTotalAmountButtonAction(_ sender: Any) {
    }
    
    @IBAction func decreaseTotalAmountButtonAction(_ sender: Any) {
    }
    
    @IBAction func increaseTotalDiscountButtonAction(_ sender: Any) {
    }
    
    @IBAction func decreaseTotalDiscountButtonACtion(_ sender: Any) {
    }
    
    @IBAction func increasenetTotalButtonAction(_ sender: Any) {
    }
    
    @IBAction func decreaseNetTotalButtonAction(_ sender: Any) {
    }
    
    @IBAction func cancelbuttonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }
}

extension AddNewBookingVC {
    func setupUserMenu() {
        let users = ["touqueir", "Ragav", "RAGAVENDIRAN A", "Nilu", "Maheswar", "Yedukondalu"]
        let actions = users.map { user in
            UIAction(title: user) { [weak self] _ in
                self?.addUserButton.setTitle(user, for: .normal)
            }
        }
        addUserButton.menu = UIMenu(children: actions)
        addUserButton.showsMenuAsPrimaryAction = true
    }
    
    func setupRoomMenu() {
        let rooms = ["Single Room", "Double Room", "Suite", "Deluxe"]
        let actions = rooms.map { room in
            UIAction(title: room) { [weak self] _ in
                self?.roomTypeButton.setTitle(room, for: .normal)
            }
        }
        roomTypeButton.menu = UIMenu(children: actions)
        roomTypeButton.showsMenuAsPrimaryAction = true
    }
    
    func setupBookingTypeMenu() {
        let bookingTypes = ["International", "Local"]
        let actions = bookingTypes.map { type in
            UIAction(title: type) { [weak self] _ in
                self?.bookingTypeButton.setTitle(type, for: .normal)
            }
        }
        bookingTypeButton.menu = UIMenu(children: actions)
        bookingTypeButton.showsMenuAsPrimaryAction = true
    }
    
    func setupStatusMenu() {
        let statuses = ["Pending","Confirmed","CheckedIn","CheckedOut","Cancelled","NoShow"]
        let actions = statuses.map { status in
            UIAction(title: status) { [weak self] _ in
                self?.statusButton.setTitle(status, for: .normal)
            }
        }
        statusButton.menu = UIMenu(children: actions)
        statusButton.showsMenuAsPrimaryAction = true
    }
}
