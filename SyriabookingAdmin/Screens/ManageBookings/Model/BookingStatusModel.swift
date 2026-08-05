//
//  BookingStatusModel.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 30/07/26.
//

import Foundation

struct BookingStatusModel {
    let title: String
    let iconName: String
}

//struct BookingModel {
//    let bookingId: String
//    let guestName: String
//    let guestPhone: String
//    let roomId: String
//    let checkInDate: String
//    let checkOutDate: String
//    let amount: Double
//    let discount: Double
//    let netTotal: Double
//    let status: String
//    let bookingType: String
//}

struct BookingModel {
    let bookingId: String
    let guestName: String
    let guestPhone: String
    let guestEmail: String
    let guestCount: Int
    let roomId: String
    let checkInDate: String
    let checkOutDate: String
    let amount: Double
    let discount: Double
    let netTotal: Double
    let bookingDetails: String
    let status: String
    let bookingType: String

    init(
        bookingId: String,
        guestName: String,
        guestPhone: String,
        guestEmail: String = "",
        guestCount: Int = 1,
        roomId: String,
        checkInDate: String,
        checkOutDate: String,
        amount: Double,
        discount: Double,
        netTotal: Double,
        bookingDetails: String = "",
        status: String,
        bookingType: String
    ) {
        self.bookingId = bookingId
        self.guestName = guestName
        self.guestPhone = guestPhone
        self.guestEmail = guestEmail
        self.guestCount = guestCount
        self.roomId = roomId
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.amount = amount
        self.discount = discount
        self.netTotal = netTotal
        self.bookingDetails = bookingDetails
        self.status = status
        self.bookingType = bookingType
    }
}
