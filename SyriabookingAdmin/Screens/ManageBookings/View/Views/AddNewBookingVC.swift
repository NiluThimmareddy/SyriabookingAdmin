//
//  AddNewBookingVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 31/07/26.

import UIKit
import FSCalendar

enum DateSelectionType {
    case checkIn
    case checkOut
}

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
    @IBOutlet weak var newBookingIconImgView: UIImageView!
    
    var guestCount = 1
    var totalAmount = 0
    var discountPercentage = 0
    var netTotal = 0
    var amountStep = 10
    
    var selectedDateField: UITextField?
    private var calendarView: FSCalendar!
    private var dimView: UIView!
    var currentSelectionType: DateSelectionType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func increaseGuestsCountButtonAction(_ sender: Any) {
        guestCount += 1
        noOfGuestsTF.text = "\(guestCount)"
    }

    @IBAction func decreaseGuestsCountButtonAction(_ sender: Any) {
        if guestCount > 1 {
            guestCount -= 1
            noOfGuestsTF.text = "\(guestCount)"
        }
    }
    
    @IBAction func checkInCalendarButtonAction(_ sender: Any) {
        currentSelectionType = .checkIn
        selectedDateField = checkInDateTF
        showCalendar()
    }

    @IBAction func checkOutCalendarButtonAction(_ sender: Any) {
        currentSelectionType = .checkOut
        selectedDateField = checkOutDateTF
        showCalendar()
    }
    
    @IBAction func increaseTotalAmountButtonAction(_ sender: Any) {
        totalAmount += 10
        updateNetTotal()
    }

    @IBAction func decreaseTotalAmountButtonAction(_ sender: Any) {
        if totalAmount >= 10 {
            totalAmount -= 10
            updateNetTotal()
        }
    }
    
    @IBAction func increaseTotalDiscountButtonAction(_ sender: Any) {
        if discountPercentage < 100 {
            discountPercentage += 5
            updateNetTotal()
        }
    }

    @IBAction func decreaseTotalDiscountButtonACtion(_ sender: Any) {
        if discountPercentage > 0 {
            discountPercentage -= 5
            updateNetTotal()
        }
    }

    @IBAction func increasenetTotalButtonAction(_ sender: Any) {
        netTotal += amountStep
        netTotalTF.text = "\(netTotal)"
    }

    @IBAction func decreaseNetTotalButtonAction(_ sender: Any) {
        if netTotal >= amountStep {
            netTotal -= amountStep
            netTotalTF.text = "\(netTotal)"
        }
    }
    
    @IBAction func cancelbuttonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }
}

extension AddNewBookingVC {
    
    func setUpUI() {
        setupUserMenu()
        setupRoomMenu()
        setupBookingTypeMenu()
        setupStatusMenu()
        
        noOfGuestsTF.text = "\(guestCount)"
        totalAmountTF.text = "\(totalAmount)"
        totalDiscountTF.text = "\(discountPercentage)"
        netTotalTF.text = "\(netTotal)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: Date())
        checkInDateTF.text = today
        checkOutDateTF.text = today
        
        newBookingIconImgView.tintColor = ThemeManager.shared.currentColor
    }
    
    func updateNetTotal() {
        let discountAmount = (totalAmount * discountPercentage) / 100
        netTotal = totalAmount - discountAmount
        totalAmountTF.text = "\(totalAmount)"
        totalDiscountTF.text = "\(discountPercentage)%"
        netTotalTF.text = "\(netTotal)"
    }
    
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
    
    func showCalendar() {
        dimView = UIView(frame: view.bounds)
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideCalendar))
        dimView.addGestureRecognizer(tap)
        view.addSubview(dimView)

        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        containerView.frame = CGRect(x: 150,y: 50,width: 350,height: 350)

        calendarView = FSCalendar(frame: containerView.bounds)
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.appearance.headerDateFormat = "MMMM yyyy"
        calendarView.appearance.headerTitleColor = ThemeManager.shared.currentColor
        calendarView.appearance.weekdayTextColor = ThemeManager.shared.currentColor
        calendarView.appearance.todayColor = ThemeManager.shared.currentColor
        calendarView.appearance.selectionColor = ThemeManager.shared.currentColor

        containerView.addSubview(calendarView)
        view.addSubview(containerView)
    }
    
    @objc func hideCalendar() {
        calendarView.superview?.removeFromSuperview()
        dimView.removeFromSuperview()
    }
}

extension AddNewBookingVC: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar,didSelect date: Date,at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: date)
        switch currentSelectionType {
        case .checkIn:
            checkInDateTF.text = selectedDate
            if let checkoutText = checkOutDateTF.text,
               let checkoutDate = formatter.date(from: checkoutText),
               checkoutDate < date {
                checkOutDateTF.text = selectedDate
            }
        case .checkOut:
            if let checkInText = checkInDateTF.text,
               let checkInDate = formatter.date(from: checkInText),
               date >= checkInDate {
                checkOutDateTF.text = selectedDate
            } else {
                let alert = UIAlertController(
                    title: "Invalid Date",
                    message: "Check-out date cannot be earlier than check-in date.",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return
            }
        case .none:
            break
        }
        hideCalendar()
    }
}
