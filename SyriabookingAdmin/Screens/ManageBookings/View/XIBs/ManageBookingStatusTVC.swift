//
//  ManageBookingStatusTVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 30/07/26.
//

import UIKit

class ManageBookingStatusTVC: UITableViewCell {

    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var bookingIdLabel: UILabel!
    @IBOutlet weak var guestNameLabel: UILabel!
    @IBOutlet weak var guestPhoneNoLabel: UILabel!
    @IBOutlet weak var roomIdLabel: UILabel!
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var checkOutLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var netTotalLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var bookingTypeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func checkmarkButtonAction(_ sender: Any) {
    }
    
    func configure(_with bookings : BookingModel) {
        bookingIdLabel.text = bookings.bookingId
        guestNameLabel.text = bookings.guestName
        guestPhoneNoLabel.text = bookings.guestPhone
        roomIdLabel.text = bookings.roomId
        checkInLabel.text = bookings.checkInDate
        checkOutLabel.text = bookings.checkOutDate
        amountLabel.text = "\(bookings.amount)"
        discountLabel.text = "\(bookings.discount)"
        netTotalLabel.text = "\(bookings.netTotal)"
        statusLabel.text = bookings.status
        bookingTypeLabel.text = bookings.bookingType
    }
    
}
