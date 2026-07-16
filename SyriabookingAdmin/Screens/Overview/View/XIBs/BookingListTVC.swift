//
//  BookingListTVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 15/07/26.
//

import UIKit

class BookingListTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var roomBookedDatesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_with bookings: BookingSummary) {
        userNameLabel.text = bookings.guestName
        roomBookedDatesLabel.text = "\(bookings.checkInDate) to \(bookings.checkOutDate)"
    }
}
