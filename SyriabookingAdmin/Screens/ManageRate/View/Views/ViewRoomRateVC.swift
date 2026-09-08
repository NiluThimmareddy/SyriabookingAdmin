//
//  ViewRoomRateVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 08/09/26.

import UIKit
import FSCalendar

class ViewRoomRateVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var viewRateLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var effectiveDateLabel: UILabel!
    @IBOutlet weak var effectiveDateTF: UITextField!
    @IBOutlet weak var effectiveDateButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var increasePriceButton: UIButton!
    @IBOutlet weak var decreasePriceButtonAction: UIButton!
    @IBOutlet weak var usedLabel: UILabel!
    @IBOutlet weak var baseCurrencyUSDLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var discountTF: UITextField!
    @IBOutlet weak var increaseDiscountButton: UIButton!
    @IBOutlet weak var decreaseDiscountButtonAction: UIButton!
    @IBOutlet weak var discountInPercentLabel: UILabel!
    @IBOutlet weak var localPriceLabel: UILabel!
    @IBOutlet weak var localPriceTF: UITextField!
    @IBOutlet weak var increaseLocalPriceButton: UIButton!
    @IBOutlet weak var decreaseLocalPriceButton: UIButton!
    @IBOutlet weak var localCurrencySYPLabel: UILabel!
    @IBOutlet weak var localDiscountLabel: UILabel!
    @IBOutlet weak var localDiscountTF: UITextField!
    @IBOutlet weak var increaseLocalDiscountButton: UIButton!
    @IBOutlet weak var decreaseLocalDiscountButton: UIButton!
    @IBOutlet weak var localDiscountCurrencyLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteTF: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    private var isEditingRoomRate = false
    
    var roomRate: RoomRateModel?
    var onDismiss: (() -> Void)?
    
    private var calendarView: FSCalendar!
    private var dimView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    @IBAction func effectiveDateButtonAction(_ sender: Any) {
        guard isEditingRoomRate else { return }
        showCalendar()
    }
    
    @IBAction func increasePriceButtonAction(_ sender: Any) {
        guard isEditingRoomRate else { return }
        let currentPrice = Double(priceTF.text ?? "") ?? 0.0
        let newPrice = currentPrice + 1.0
        priceTF.text = String(format: "%.2f", newPrice)
    }
    
    @IBAction func decreasePriceButtonAction(_ sender: Any) {
        guard isEditingRoomRate else { return }
        let currentPrice = Double(priceTF.text ?? "") ?? 0.0
        if currentPrice >= 1.0 {
            let newPrice = currentPrice - 1.0
            priceTF.text = String(format: "%.2f", newPrice)
        }
    }
    
    @IBAction func increaseDiscountButtonActtion(_ sender: Any) {
        guard isEditingRoomRate else { return }
        let currentDiscount = Int(discountTF.text ?? "") ?? 0
        if currentDiscount < 100 {
            let newDiscount = min(currentDiscount + 5, 100)
            discountTF.text = "\(newDiscount)"
        }
    }
    
    @IBAction func decreaseDiscountButtonAction(_ sender: Any) {
        guard isEditingRoomRate else { return }
        let currentDiscount = Int(discountTF.text ?? "") ?? 0
        if currentDiscount > 0 {
            let newDiscount = max(currentDiscount - 5, 0)
            discountTF.text = "\(newDiscount)"
        }
    }
    
    @IBAction func increaseLocalPriceButtonAction(_ sender: Any) {
        guard isEditingRoomRate else { return }
        let currentPrice = Double(localPriceTF.text ?? "") ?? 0.0
        let newPrice = currentPrice + 1.0
        localPriceTF.text = String(format: "%.2f", newPrice)
    }
    
    @IBAction func decreaseLocalPriceButtonAction(_ sender: Any) {
        guard isEditingRoomRate else { return }
        let currentPrice = Double(localPriceTF.text ?? "") ?? 0.0
        if currentPrice >= 1.0 {
            let newPrice = currentPrice - 1.0
            localPriceTF.text = String(format: "%.2f", newPrice)
        }
    }
    
    @IBAction func increaseLocalDiscountButtonAction(_ sender: Any) {
        guard isEditingRoomRate else { return }
        let currentDiscount = Int(localDiscountTF.text ?? "") ?? 0
        if currentDiscount < 100 {
            let newDiscount = min(currentDiscount + 5, 100)
            localDiscountTF.text = "\(newDiscount)"
        }
    }
    
    @IBAction func decreaseLocalDiscountButtonAction(_ sender: Any) {
        guard isEditingRoomRate else { return }
        let currentDiscount = Int(localDiscountTF.text ?? "") ?? 0
        if currentDiscount > 0 {
            let newDiscount = max(currentDiscount - 5, 0)
            localDiscountTF.text = "\(newDiscount)"
        }
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        onDismiss?()
        dismiss(animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        if isEditingRoomRate {
            saveRoomRate()
        } else {
            setupEditMode()
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
    }
}


extension ViewRoomRateVC {
    func setUpUI() {
        iconImgView.tintColor = ThemeManager.shared.currentColor
        setupViewMode()
        configureRoomRateData()
    }
    
    private func configureRoomRateData() {
        guard let roomRate = roomRate else {
            return
        }
        idTF.text = roomRate.id
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        effectiveDateTF.text = dateFormatter.string(from: roomRate.effectiveDate)
        priceTF.text = String(roomRate.price)
        discountTF.text = String(roomRate.discount)
        localPriceTF.text = String(roomRate.localPrice)
        localDiscountTF.text = String(roomRate.localDiscount)
        noteTF.text = roomRate.notes
    }
    
    private func setupViewMode() {
        isEditingRoomRate = false
        idTF.isUserInteractionEnabled = false
        effectiveDateTF.isUserInteractionEnabled = false
        priceTF.isUserInteractionEnabled = false
        discountTF.isUserInteractionEnabled = false
        localPriceTF.isUserInteractionEnabled = false
        localDiscountTF.isUserInteractionEnabled = false
        noteTF.isUserInteractionEnabled = false

        effectiveDateButton.isUserInteractionEnabled = false
        increasePriceButton.isUserInteractionEnabled = false
        decreasePriceButtonAction.isUserInteractionEnabled = false
        increaseDiscountButton.isUserInteractionEnabled = false
        decreaseDiscountButtonAction.isUserInteractionEnabled = false
        increaseLocalPriceButton.isUserInteractionEnabled = false
        decreaseLocalPriceButton.isUserInteractionEnabled = false
        increaseLocalDiscountButton.isUserInteractionEnabled = false
        decreaseLocalDiscountButton.isUserInteractionEnabled = false

        editButton.isHidden = false
        deleteButton.isHidden = false

        editButton.setTitle("Edit", for: .normal)

        iconImgView.image = UIImage(systemName: "eye")
        viewRateLabel.text = "View Rate"
    }
    
    private func setupEditMode() {

        isEditingRoomRate = true

        idTF.isUserInteractionEnabled = true
        effectiveDateTF.isUserInteractionEnabled = false
        priceTF.isUserInteractionEnabled = true
        discountTF.isUserInteractionEnabled = true
        localPriceTF.isUserInteractionEnabled = true
        localDiscountTF.isUserInteractionEnabled = true
        noteTF.isUserInteractionEnabled = true
        effectiveDateButton.isUserInteractionEnabled = true
        increasePriceButton.isUserInteractionEnabled = true
        decreasePriceButtonAction.isUserInteractionEnabled = true
        increaseDiscountButton.isUserInteractionEnabled = true
        decreaseDiscountButtonAction.isUserInteractionEnabled = true
        increaseLocalPriceButton.isUserInteractionEnabled = true
        decreaseLocalPriceButton.isUserInteractionEnabled = true
        increaseLocalDiscountButton.isUserInteractionEnabled = true
        decreaseLocalDiscountButton.isUserInteractionEnabled = true
        deleteButton.isHidden = true
        closeButton.tintColor = UIColor(hex: "DD2525")
        editButton.setTitle("Save", for: .normal)
        iconImgView.image = UIImage(named: "ic_edit")
        viewRateLabel.text = "Update Rate"
    }
    
    private func saveRoomRate() {

        let id = idTF.text ?? ""
        let effectiveDateString = effectiveDateTF.text ?? ""

        let price = Double(priceTF.text ?? "") ?? 0.0
        let discount = Int(discountTF.text ?? "") ?? 0
        let localPrice = Double(localPriceTF.text ?? "") ?? 0.0
        let localDiscount = Int(localDiscountTF.text ?? "") ?? 0
        let notes = noteTF.text ?? ""

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let effectiveDate = dateFormatter.date(from: effectiveDateString) else {
            print("Invalid effective date: \(effectiveDateString)")
            return
        }
        roomRate = RoomRateModel(
            id: id,
            effectiveDate: effectiveDate,
            price: price,
            discount: discount,
            notes: notes,
            localPrice: localPrice,
            localDiscount: localDiscount
        )
        setupViewMode()
        closeButton.tintColor = UIColor(hex: "575757")
    }
    
    private func showCalendar() {
        calendarView?.superview?.removeFromSuperview()
        dimView?.removeFromSuperview()
        dimView = UIView(frame: view.bounds)
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(hideCalendar)
        )
        dimView.addGestureRecognizer(tap)
        view.addSubview(dimView)

        let containerView = UIView(
            frame: CGRect(
                x: 150,
                y: 50,
                width: 350,
                height: 350
            )
        )
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
    
    @objc private func hideCalendar() {
        calendarView?.superview?.removeFromSuperview()
        dimView?.removeFromSuperview()
        calendarView = nil
        dimView = nil
    }
}

extension ViewRoomRateVC: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar,didSelect date: Date,at monthPosition: FSCalendarMonthPosition) {
        guard isEditingRoomRate else {
            hideCalendar()
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        effectiveDateTF.text = formatter.string(from: date)
        hideCalendar()
    }
}
