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

struct BookingModel {
    let bookingId: String
    let guestName: String
    let guestPhone: String
    let roomId: String
    let checkInDate: String
    let checkOutDate: String
    let amount: Double
    let discount: Double
    let netTotal: Double
    let status: String
    let bookingType: String
}
