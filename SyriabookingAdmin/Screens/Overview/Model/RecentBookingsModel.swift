//
//  RecentBookingsModel.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 15/07/26.
//

import Foundation

struct Booking: Identifiable {
    let id: String
    let guestInitials: String
    let guestName: String
    let roomNumber: String
    let checkInDate: String
    let status: BookingStatus
}

enum BookingStatus: String {
    case pending = "Pending"
    case confirmed = "Confirmed"
    case cancelled = "Cancelled"
}

struct BookingSummary {
    let guestName: String
    let checkInDate: String
    let checkOutDate: String
}


struct BookingInvoice {
    let isIncluded: Bool
    let bookingId: String
    let guestName: String
    let checkInDate: String
    let netTotal: Double
    let commission: Double
    let tax: Double
    var isDisputed: Bool
}
