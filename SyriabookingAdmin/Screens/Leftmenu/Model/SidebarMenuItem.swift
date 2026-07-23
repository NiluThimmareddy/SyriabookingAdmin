//
//  SidebarMenuItem.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 14/07/26.
//

import Foundation


struct SidebarMenuItem {
    let title: String
    let icon: String
}

enum SidebarMenu: Int {
    case overview = 0
    case hotelInvoices
    case manageBookings
    case manageReviews
    case manageDiscounts
    case manageFacilities
    case manageLandmarks
    case managePolicies
    case manageImages
    case manageRooms
}
