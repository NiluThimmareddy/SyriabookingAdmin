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
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var calendarImgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        calendarView.backgroundColor = ThemeManager.shared.currentColor.withAlphaComponent(0.2)
        calendarImgView.tintColor = ThemeManager.shared.currentColor
    }
    
    func configure(_with bookings: BookingSummary) {
        userNameLabel.text = bookings.guestName
        roomBookedDatesLabel.text = "\(bookings.checkInDate) to \(bookings.checkOutDate)"
    }
}
