//
//  RecentBookingsTVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 15/07/26.
//

import UIKit

class RecentBookingsTVC : UITableViewCell {

    @IBOutlet weak var bookingIdLabel: UILabel!
    @IBOutlet weak var guestStartingNameLetterLabel: UILabel!
    @IBOutlet weak var guestNameLabel: UILabel!
    @IBOutlet weak var roomIdLabel: UILabel!
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var pendingButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guestStartingNameLetterLabel.layer.masksToBounds = true
    }
    
    func configure(_with recentBook : Booking) {
        bookingIdLabel.text = recentBook.id
        guestStartingNameLetterLabel.text = recentBook.guestInitials
        guestNameLabel.text = recentBook.guestName
        roomIdLabel.text = recentBook.roomNumber
        checkInDateLabel.text = recentBook.checkInDate
    }
    
}
