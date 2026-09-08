//
//  AddNewRoomRateVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 08/09/26.
//

import UIKit
import FSCalendar

class AddNewRoomRateVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var plusIconImgView: UIImageView!
    @IBOutlet weak var addNewRateLabel: UILabel!
    @IBOutlet weak var effectiveDateLabel: UILabel!
    @IBOutlet weak var effectiveDateTF: UITextField!
    @IBOutlet weak var effectiveDateButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var increasePriceButton: UIButton!
    @IBOutlet weak var decreasePriceButton: UIButton!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var baseCurrencyUSDLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var discountTF: UITextField!
    @IBOutlet weak var increaseDiscountButton: UIButton!
    @IBOutlet weak var decreaseDiscountButton: UIButton!
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
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    private var calendarView: FSCalendar!
    private var dimView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func effectiveDateButtonAction(_ sender: Any) {
        showCalendar()
    }
    
    @IBAction func increasePriceButtonAction(_ sender: Any) {
        let currentPrice = Double(priceTF.text ?? "") ?? 0.0
        let newPrice = currentPrice + 1.0
        priceTF.text = String(format: "%.2f", newPrice)
    }
    
    @IBAction func decreasePriceButtonAction(_ sender: Any) {
        let currentPrice = Double(priceTF.text ?? "") ?? 0.0
        if currentPrice >= 1.0 {
            let newPrice = currentPrice - 1.0
            priceTF.text = String(format: "%.2f", newPrice)
        }
    }
    
    @IBAction func increaseDiscountButtonActtion(_ sender: Any) {
        let currentDiscount = Int(discountTF.text ?? "") ?? 0
        if currentDiscount < 100 {
            let newDiscount = min(currentDiscount + 5, 100)
            discountTF.text = "\(newDiscount)"
        }
    }
    
    @IBAction func decreaseDiscountButtonAction(_ sender: Any) {
        let currentDiscount = Int(discountTF.text ?? "") ?? 0
        if currentDiscount > 0 {
            let newDiscount = max(currentDiscount - 5, 0)
            discountTF.text = "\(newDiscount)"
        }
    }
    
    @IBAction func increaseLocalPriceButtonAction(_ sender: Any) {
        let currentPrice = Double(localPriceTF.text ?? "") ?? 0.0
        let newPrice = currentPrice + 1.0
        localPriceTF.text = String(format: "%.2f", newPrice)
    }
    
    @IBAction func decreaseLocalPriceButtonAction(_ sender: Any) {
        let currentPrice = Double(localPriceTF.text ?? "") ?? 0.0
        if currentPrice >= 1.0 {
            let newPrice = currentPrice - 1.0
            localPriceTF.text = String(format: "%.2f", newPrice)
        }
    }
    
    @IBAction func increaseLocalDiscountButtonAction(_ sender: Any) {
        let currentDiscount = Int(localDiscountTF.text ?? "") ?? 0
        if currentDiscount < 100 {
            let newDiscount = min(currentDiscount + 5, 100)
            localDiscountTF.text = "\(newDiscount)"
        }
    }
    
    @IBAction func decreaseLocalDiscountButtonAction(_ sender: Any) {
        let currentDiscount = Int(localDiscountTF.text ?? "") ?? 0
        if currentDiscount > 0 {
            let newDiscount = max(currentDiscount - 5, 0)
            localDiscountTF.text = "\(newDiscount)"
        }
    }
    
    @IBAction func canccelButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }
}


extension AddNewRoomRateVC {
    func setUpUI() {
        
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

extension AddNewRoomRateVC: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar,didSelect date: Date,at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        effectiveDateTF.text = formatter.string(from: date)
        hideCalendar()
    }
}
