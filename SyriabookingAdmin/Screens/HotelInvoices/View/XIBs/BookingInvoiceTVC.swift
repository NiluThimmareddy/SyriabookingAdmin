//
//  BookingInvoiceTVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 28/07/26.
//

import UIKit

class BookingInvoiceTVC: UITableViewCell {

    @IBOutlet weak var includeButton: UIButton!
    @IBOutlet weak var bookingIDLabel: UILabel!
    @IBOutlet weak var guestNameLabel: UILabel!
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var netTotalLabel: UILabel!
    @IBOutlet weak var commisionLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var disputeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func includeButtonAction(_ sender: Any) {
    }
    
    @IBAction func disputeButtonAction(_ sender: Any) {
    }
    
    func configure(_with bookingInvoice : BookingInvoice) {
        bookingIDLabel.text = bookingInvoice.bookingId
        guestNameLabel.text = bookingInvoice.guestName
        checkInLabel.text = bookingInvoice.checkInDate
        netTotalLabel.text = "\(bookingInvoice.netTotal)"
        commisionLabel.text = "\(bookingInvoice.commission)"
        taxLabel.text = "\(bookingInvoice.tax)"
    }
    
}
