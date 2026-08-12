//
//  ViewBookingVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 03/08/26.
//

import UIKit
import FSCalendar

class ViewBookingVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var viewBookingTitleLabel: UILabel!
    @IBOutlet weak var bookingIdTitleLabel: UILabel!
    @IBOutlet weak var bookingIdTF: UITextField!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var addUserButton: UIButton!
    @IBOutlet weak var roomTypeButton: UIButton!
    @IBOutlet weak var bookingTypeButton: UIButton!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var guestnameLabel: UILabel!
    @IBOutlet weak var guestNameTF: UITextField!
    @IBOutlet weak var guestPhoneLabel: UILabel!
    @IBOutlet weak var guestPhoneNoTF: UITextField!
    @IBOutlet weak var guestEmailLabel: UILabel!
    @IBOutlet weak var guestEmailTF: UITextField!
    @IBOutlet weak var guestsLabel: UILabel!
    @IBOutlet weak var guestsCountTF: UITextField!
    @IBOutlet weak var increaseGuestsCountButton: UIButton!
    @IBOutlet weak var decreaseGuestCountButton: UIButton!
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var checkInDateTF: UITextField!
    @IBOutlet weak var checkInDateButton: UIButton!
    @IBOutlet weak var checkOutLabel: UILabel!
    @IBOutlet weak var checkOutDateTF: UITextField!
    @IBOutlet weak var checkOutDateButton: UIButton!
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
    @IBOutlet weak var bookingDetailsLabel: UILabel!
    @IBOutlet weak var bookingDetailsTF: UITextField!
    @IBOutlet weak var bookingTypeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var viewDetailsButton: UIButton!
    
    var booking: BookingModel?
    var onDismiss: (() -> Void)?
    
    var guestCount = 1
    var totalAmount = 0
    var discountPercentage = 0
    var netTotal = 0
    var amountStep = 1

    var selectedDateField: UITextField?
    private var calendarView: FSCalendar!
    private var dimView: UIView!
    var currentSelectionType: DateSelectionType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setEditingEnabled(false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.isBeingDismissed {
            onDismiss?()
        }
    }
    
    @IBAction func increaseGuestCountButtonAction(_ sender: Any) {
        guard editButton.isSelected else { return }
        guestCount += 1
        guestsCountTF.text = "\(guestCount)"
    }

    @IBAction func decreaseGuestCountButtonAction(_ sender: Any) {
        guard editButton.isSelected else { return }
        if guestCount > 1 {
            guestCount -= 1
            guestsCountTF.text = "\(guestCount)"
        }
    }
    
    @IBAction func checkInDateButtonAction(_ sender: Any) {
        guard editButton.isSelected else { return }
        currentSelectionType = .checkIn
        selectedDateField = checkInDateTF
        showCalendar()
    }

    @IBAction func checkOutDateButtonAction(_ sender: Any) {
        guard editButton.isSelected else { return }
        currentSelectionType = .checkOut
        selectedDateField = checkOutDateTF
        showCalendar()
    }
    
    @IBAction func increaseTotalAmountButtonAction(_ sender: Any) {
        guard editButton.isSelected else { return }
        totalAmount += 1
        updateNetTotal()
    }

    @IBAction func decreaseTotalAmountButtonAction(_ sender: Any) {
        guard editButton.isSelected else { return }
        if totalAmount >= 1 {
            totalAmount -= 1
            updateNetTotal()
        }
    }
    
    @IBAction func increaseTotalDiscountButtonAction(_ sender: Any) {
        guard editButton.isSelected else { return }
        if discountPercentage < 100 {
            discountPercentage += 5
            updateNetTotal()
        }
    }

    @IBAction func decreaseTotalDiscountButtonAction(_ sender: Any) {
        guard editButton.isSelected else { return }
        if discountPercentage > 0 {
            discountPercentage -= 5
            updateNetTotal()
        }
    }
    
    @IBAction func increaseNetTotalButtonAction(_ sender: Any) {
        guard editButton.isSelected else { return }
        netTotal += amountStep
        netTotalTF.text = "\(netTotal)"
    }

    @IBAction func decreaseNetTotalButtonAction(_ sender: Any) {
        guard editButton.isSelected else { return }
        if netTotal >= amountStep {
            netTotal -= amountStep
            netTotalTF.text = "\(netTotal)"
        }
    }
    
    @IBAction func cancelbuttonAction(_ sender: Any) {
        dismiss(animated: true) {
            self.onDismiss?()
        }
    }
    
    @IBAction func editButtonAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            setEditingEnabled(true)
            viewDetailsButton.isHidden = true
            sender.setTitle("Save", for: .normal)
            sender.setTitleColor(UIColor(hex: "#272727"), for: .normal)
            sender.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            sender.backgroundColor = .systemBackground
        } else {
            setEditingEnabled(false)
            viewDetailsButton.isHidden = false
            sender.setTitle("Edit", for: .normal)
            sender.setTitleColor(UIColor(hex: "#272727"), for: .normal)
            sender.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            sender.backgroundColor = .systemBackground
        }
    }
    
    @IBAction func viewDetailsButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "ViewManageBookingDetailsVC") as! ViewManageBookingDetailsVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
}

extension ViewBookingVC {
    func setUpUI() {
        setupUserMenu()
        setupRoomMenu()
        setupBookingTypeMenu()
        setupStatusMenu()
        
        populateBookingData()
        
        viewDetailsButton.applyOverviewGradient()
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
    
    private func populateBookingData() {
        guard let booking = booking else { return }
        bookingIdTF.text = booking.bookingId
        guestNameTF.text = booking.guestName
        guestPhoneNoTF.text = booking.guestPhone
        guestEmailTF.text = booking.guestEmail
        guestsCountTF.text = "\(booking.guestCount)"
        bookingDetailsTF.text = booking.bookingDetails
        checkInDateTF.text = booking.checkInDate
        checkOutDateTF.text = booking.checkOutDate
        totalAmountTF.text = "\(booking.amount)"
        totalDiscountTF.text = "\(booking.discount)"
        netTotalTF.text = "\(booking.netTotal)"
        bookingTypeButton.setTitle(booking.bookingType,for: .normal)
        statusButton.setTitle(booking.status,for: .normal)
        roomTypeButton.setTitle(booking.roomId,for: .normal)
        
        guestCount = booking.guestCount
        totalAmount = Int(booking.amount)
        discountPercentage = Int(booking.discount)
        netTotal = Int(booking.netTotal)
    }
    
    private func setEditingEnabled(_ enabled: Bool) {

        // TextFields
        bookingIdTF.isUserInteractionEnabled = enabled
        guestNameTF.isUserInteractionEnabled = enabled
        guestPhoneNoTF.isUserInteractionEnabled = enabled
        guestEmailTF.isUserInteractionEnabled = enabled
        guestsCountTF.isUserInteractionEnabled = enabled
        checkInDateTF.isUserInteractionEnabled = enabled
        checkOutDateTF.isUserInteractionEnabled = enabled
        totalAmountTF.isUserInteractionEnabled = enabled
        totalDiscountTF.isUserInteractionEnabled = enabled
        netTotalTF.isUserInteractionEnabled = enabled
        bookingDetailsTF.isUserInteractionEnabled = enabled

        bookingIdTF.isEnabled = enabled
        guestNameTF.isEnabled = enabled
        guestPhoneNoTF.isEnabled = enabled
        guestEmailTF.isEnabled = enabled
        guestsCountTF.isEnabled = enabled
        checkInDateTF.isEnabled = enabled
        checkOutDateTF.isEnabled = enabled
        totalAmountTF.isEnabled = enabled
        totalDiscountTF.isEnabled = enabled
        netTotalTF.isEnabled = enabled
        bookingDetailsTF.isEnabled = enabled

        // Menu Buttons
        addUserButton.isUserInteractionEnabled = enabled
        roomTypeButton.isUserInteractionEnabled = enabled
        bookingTypeButton.isUserInteractionEnabled = enabled
        statusButton.isUserInteractionEnabled = enabled

        // Other Buttons
        increaseGuestsCountButton.isEnabled = enabled
        decreaseGuestCountButton.isEnabled = enabled

        checkInDateButton.isEnabled = enabled
        checkOutDateButton.isEnabled = enabled

        increaseTotalAmountButton.isEnabled = enabled
        decreaseTotalAmountButton.isEnabled = enabled

        increaseTotalDiscountButton.isEnabled = enabled
        decreaseTotalDiscountButton.isEnabled = enabled

        increaseNetTotalButton.isEnabled = enabled
        decreaseNetTotalButton.isEnabled = enabled
    }
    
    func showCalendar() {

        dimView = UIView(frame: view.bounds)
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.4)

        let tap = UITapGestureRecognizer(target: self, action: #selector(hideCalendar))
        dimView.addGestureRecognizer(tap)

        view.addSubview(dimView)

        let containerView = UIView(frame: CGRect(x: 150, y: 50, width: 350, height: 350))
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true

        calendarView = FSCalendar(frame: containerView.bounds)
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.appearance.headerDateFormat = "MMMM yyyy"
        calendarView.appearance.todayColor = .systemBlue
        calendarView.appearance.selectionColor = .systemPurple

        containerView.addSubview(calendarView)
        view.addSubview(containerView)
    }

    @objc
    func hideCalendar() {
        calendarView.superview?.removeFromSuperview()
        dimView.removeFromSuperview()
    }
}

extension ViewBookingVC: FSCalendarDelegate, FSCalendarDataSource {
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
