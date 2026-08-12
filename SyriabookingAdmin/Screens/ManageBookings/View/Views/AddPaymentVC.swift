//
//  AddPaymentVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 11/08/26.
//

import UIKit
import FSCalendar

enum PaidDateSelectionTypes {
    case paidDate
}

class AddPaymentVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var addPaymentLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var paymentMethodButton: UIButton!
    @IBOutlet weak var paymentStatusLabel: UILabel!
    @IBOutlet weak var paymentStatusButton: UIButton!
    @IBOutlet weak var transactionIDLabel: UILabel!
    @IBOutlet weak var transactionIdTF: UITextField!
    @IBOutlet weak var paidAtLabel: UILabel!
    @IBOutlet weak var paidAtDateTF: UITextField!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    private var calendarView: FSCalendar!
    private var dimView: UIView!
    var currentSelectionType: PaidDateSelectionTypes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    @IBAction func calendarButtonAction(_ sender: Any) {
        currentSelectionType = .paidDate
        showCalendar()
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }
    
}

extension AddPaymentVC {
    
    func setUpUI() {
        setupPaymentMethodMenu()
        setupPaymentStatusMenu()
    }
    
    func setupPaymentMethodMenu() {
        let users = ["Cash", "Card","UPI","Bank Transfer","OnlineGateway","Other"]
        let actions = users.map { user in
            UIAction(title: user) { [weak self] _ in
                self?.paymentMethodButton.setTitle(user, for: .normal)
            }
        }
        paymentMethodButton.menu = UIMenu(children: actions)
        paymentMethodButton.showsMenuAsPrimaryAction = true
    }
    
    func setupPaymentStatusMenu() {
        let users = ["Pending", "Paid","Failed","Refunded","Partial"]
        let actions = users.map { user in
            UIAction(title: user) { [weak self] _ in
                self?.paymentStatusButton.setTitle(user, for: .normal)
            }
        }
        paymentStatusButton.menu = UIMenu(children: actions)
        paymentStatusButton.showsMenuAsPrimaryAction = true
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

extension AddPaymentVC: FSCalendarDelegate, FSCalendarDataSource {

    func calendar(_ calendar: FSCalendar,didSelect date: Date,at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: date)
        switch currentSelectionType {
        case .paidDate:
            paidAtDateTF.text = selectedDate
        case .none:
            break
        }
        hideCalendar()
    }
}
