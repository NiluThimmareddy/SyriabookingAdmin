//
//  HotelViewVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 27/07/26.
//

import UIKit

class HotelViewVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var invoiceNumberLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var periodtitleLabel: UILabel!
    @IBOutlet weak var periodYearMonthLabel: UILabel!
    @IBOutlet weak var periodDatesMonthYearLabel: UILabel!
    @IBOutlet weak var datesTitleLabel: UILabel!
    @IBOutlet weak var issuedDatesLabel: UILabel!
    @IBOutlet weak var dueDatesLabel: UILabel!
    @IBOutlet weak var summarytitleLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var commisionBaseLabel: UILabel!
    @IBOutlet weak var commisionLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var subTotalValueLabel: UILabel!
    @IBOutlet weak var commisionBaseValueLabel: UILabel!
    @IBOutlet weak var commisionValueLabel: UILabel!
    @IBOutlet weak var taxValueLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var totalBookingsLabel: UILabel!
    @IBOutlet weak var pdfView: UIView!
    @IBOutlet weak var invoiceNumberGeneratedDateLabel: UILabel!
    @IBOutlet weak var viewOrDownloadPDFButton: UIButton!
    @IBOutlet weak var noBookingLinesFoundLabel: UILabel!
    @IBOutlet weak var bookingsListTableview: UITableView!
    @IBOutlet weak var bookingsListtableviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var approvebutton: UIButton!
    @IBOutlet weak var saveChangesButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var pdfViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bookingListTableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var pdfViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var pdfViewTopConstraint: NSLayoutConstraint!
    
    
    let bookings: [BookingInvoice] = [
        BookingInvoice(isIncluded: true,bookingId: "BK00277",guestName: "Mr Maheswar Reddy",checkInDate: "07 Dec 2025",netTotal: 1400.00,commission: 140.00,tax: 7.00,isDisputed: false),
        BookingInvoice(isIncluded: true,bookingId: "BK00283",guestName: "Mr Maheswar Reddy",checkInDate: "10 Dec 2025",netTotal: 2660.00,commission: 266.00,tax: 13.30,isDisputed: false),
        BookingInvoice(isIncluded: true,bookingId: "BK00309",guestName: "Mr. Ashif Ahmad",checkInDate: "20 Dec 2025",netTotal: 180.00,commission: 18.00,tax: 0.90,isDisputed: false),
        BookingInvoice(isIncluded: true,bookingId: "BK00316",guestName: "Mr Maheswar Reddy",checkInDate: "31 Dec 2025",netTotal: 3100.00,commission: 310.00,tax: 15.50,isDisputed: false),
        BookingInvoice(isIncluded: true,bookingId: "BK00317",guestName: "Mr Maheswar Reddy",checkInDate: "22 Dec 2025",netTotal: 140.00,commission: 14.00,tax: 0.70,isDisputed: false)
    ]
    
    var selectedInvoice: Invoice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bookingsListTableview.reloadData()
        bookingsListTableview.layoutIfNeeded()
        if !bookingsListTableview.isHidden {
            bookingsListtableviewHeightConstraint.constant = bookingsListTableview.contentSize.height
        }
    }
    
    @IBAction func dismissButtonaction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func viewOrDownloadPDFButtonAction(_ sender: Any) {
    }
    
    @IBAction func approvebuttonAction(_ sender: Any) {
    }
    
    @IBAction func saveChangesButtonAction(_ sender: Any) {
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}


extension HotelViewVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingInvoiceTVC") as! BookingInvoiceTVC
        let bookingInvoice = bookings[indexPath.row]
        cell.configure(_with: bookingInvoice)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("BookingInvoiceView", owner: self, options: nil)?.first as? BookingInvoiceView else {
            return nil
        }
        return headerView
    }
    func tableView(_ tableView: UITableView,heightForHeaderInSection section: Int) -> CGFloat {
        return 50 
    }
}


extension HotelViewVC {
    func setUpUI() {
        view.backgroundColor = UIColor.label.withAlphaComponent(0.5)
        scrollView.showsVerticalScrollIndicator = false
        
        bookingsListTableview.register(UINib(nibName: "BookingInvoiceTVC", bundle: nil),forCellReuseIdentifier: "BookingInvoiceTVC")
        bookingsListTableview.isScrollEnabled = false

        noBookingLinesFoundLabel.isHidden = true
        pdfView.isHidden = false
        pdfViewHeightConstraint.constant = 50
        bookingsListTableview.isHidden = false
        bookingsListtableviewHeightConstraint.constant = 321.68
        approvebutton.isHidden = false
        saveChangesButton.isHidden = false
        
        pdfViewTopConstraint.constant = 20
        pdfViewBottomConstraint.constant = 20
        bookingListTableViewTopConstraint.constant = 20

        guard let invoice = selectedInvoice else { return }
        statusLabel.text = invoice.status.rawValue
        switch invoice.status {

        case .canceled:

            statusView.backgroundColor = UIColor(hex: "FEF2F2")
            statusLabel.textColor = UIColor(hex: "B91C1C")

            noBookingLinesFoundLabel.isHidden = false

            pdfView.isHidden = true
            pdfViewHeightConstraint.constant = 0
            pdfViewTopConstraint.constant = 0
            pdfViewBottomConstraint.constant = 0

            bookingsListTableview.isHidden = true
            bookingsListtableviewHeightConstraint.constant = 0
            bookingListTableViewTopConstraint.constant = 0

            approvebutton.isHidden = true
            saveChangesButton.isHidden = true

        case .draft:

            statusView.backgroundColor = UIColor(hex: "F3F4F6")
            statusLabel.textColor = UIColor(hex: "4B5563")

            pdfView.isHidden = true
            pdfViewHeightConstraint.constant = 0
            pdfViewTopConstraint.constant = 0
            pdfViewBottomConstraint.constant = 0

            bookingListTableViewTopConstraint.constant = 0

        case .disputed:

            statusView.backgroundColor = UIColor(hex: "FFF7ED")
            statusLabel.textColor = UIColor(hex: "C2410C")

            pdfView.isHidden = true
            pdfViewHeightConstraint.constant = 0
            pdfViewTopConstraint.constant = 0
            pdfViewBottomConstraint.constant = 0

            bookingListTableViewTopConstraint.constant = 0

        case .paid:

            statusView.backgroundColor = UIColor(hex: "F0FDF4")
            statusLabel.textColor = UIColor(hex: "15803D")

            pdfViewTopConstraint.constant = 20
            pdfViewBottomConstraint.constant = 20
            bookingListTableViewTopConstraint.constant = 20

            approvebutton.isHidden = true
            saveChangesButton.isHidden = true

        case .partiallyPaid:

            statusView.backgroundColor = UIColor(hex: "EFF6FF")
            statusLabel.textColor = UIColor(hex: "1D4ED8")

            pdfViewTopConstraint.constant = 20
            pdfViewBottomConstraint.constant = 20
            bookingListTableViewTopConstraint.constant = 20

            approvebutton.isHidden = true
            saveChangesButton.isHidden = true

        case .approved:

            statusView.backgroundColor = UIColor(hex: "F0FDF4")
            statusLabel.textColor = UIColor(hex: "15803D")

            pdfView.isHidden = true
            pdfViewHeightConstraint.constant = 0
            pdfViewTopConstraint.constant = 0
            pdfViewBottomConstraint.constant = 0

            bookingListTableViewTopConstraint.constant = 0

            approvebutton.isHidden = true
            saveChangesButton.isHidden = true
        }
        view.layoutIfNeeded()
    }
}
