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
    
    let bookings: [BookingInvoice] = [
        BookingInvoice(isIncluded: true,bookingId: "BK00277",guestName: "Mr Maheswar Reddy",checkInDate: "07 Dec 2025",netTotal: 1400.00,commission: 140.00,tax: 7.00,isDisputed: false),
        BookingInvoice(isIncluded: true,bookingId: "BK00283",guestName: "Mr Maheswar Reddy",checkInDate: "10 Dec 2025",netTotal: 2660.00,commission: 266.00,tax: 13.30,isDisputed: false),
        BookingInvoice(isIncluded: true,bookingId: "BK00309",guestName: "Mr. Ashif Ahmad",checkInDate: "20 Dec 2025",netTotal: 180.00,commission: 18.00,tax: 0.90,isDisputed: false),
        BookingInvoice(isIncluded: true,bookingId: "BK00316",guestName: "Mr Maheswar Reddy",checkInDate: "31 Dec 2025",netTotal: 3100.00,commission: 310.00,tax: 15.50,isDisputed: false),
        BookingInvoice(isIncluded: true,bookingId: "BK00317",guestName: "Mr Maheswar Reddy",checkInDate: "22 Dec 2025",netTotal: 140.00,commission: 14.00,tax: 0.70,isDisputed: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.showsVerticalScrollIndicator = false
        bookingsListTableview.register(UINib(nibName: "BookingInvoiceTVC", bundle: nil), forCellReuseIdentifier: "BookingInvoiceTVC")
        bookingsListTableview.isScrollEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bookingsListTableview.reloadData()
        bookingsListTableview.layoutIfNeeded()
        bookingsListtableviewHeightConstraint.constant = bookingsListTableview.contentSize.height
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
