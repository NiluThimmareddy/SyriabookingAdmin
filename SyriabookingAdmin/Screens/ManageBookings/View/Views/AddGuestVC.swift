//
//  AddGuestVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 11/08/26.
//

import UIKit
import FSCalendar

enum DateSelectionTypes {
    case dateOfBirth
}

class AddGuestVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var addGuestTitleLabel: UILabel!
    @IBOutlet weak var fullnameTitleLabel: UILabel!
    @IBOutlet weak var fullnameTF: UITextField!
    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var phoneNoTF: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var identificationNoLabel: UILabel!
    @IBOutlet weak var identificationNoTF: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var dateOfBirthTF: UITextField!
    @IBOutlet weak var dateOfBirthButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var addGuestIconImageView: UIImageView!
    private var calendarView: FSCalendar!
    private var dimView: UIView!
    var currentSelectionType: DateSelectionTypes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func dateOfBirthButtonAction(_ sender: Any) {
        currentSelectionType = .dateOfBirth
        showCalendar()
    }
    
    @IBAction func cancelbuttonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }

}


extension AddGuestVC {
    
    func setUpUI() {
        addGuestIconImageView.tintColor = ThemeManager.shared.currentColor
        setupGenderMenu()
    }
    
    func setupGenderMenu() {
        let users = ["Male", "Female","Other"]
        let actions = users.map { user in
            UIAction(title: user) { [weak self] _ in
                self?.genderButton.setTitle(user, for: .normal)
            }
        }
        genderButton.menu = UIMenu(children: actions)
        genderButton.showsMenuAsPrimaryAction = true
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
        calendarView.appearance.headerTitleColor = ThemeManager.shared.currentColor
        calendarView.appearance.weekdayTextColor = ThemeManager.shared.currentColor
        calendarView.appearance.todayColor = ThemeManager.shared.currentColor
        calendarView.appearance.selectionColor = ThemeManager.shared.currentColor

        containerView.addSubview(calendarView)
        view.addSubview(containerView)
    }

    @objc
    func hideCalendar() {
        calendarView.superview?.removeFromSuperview()
        dimView.removeFromSuperview()
    }
}

extension AddGuestVC: FSCalendarDelegate, FSCalendarDataSource {

    func calendar(_ calendar: FSCalendar,didSelect date: Date,at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: date)
        switch currentSelectionType {
        case .dateOfBirth:
            dateOfBirthTF.text = selectedDate
        case .none:
            break
        }
        hideCalendar()
    }
}
