//
//  RoomRateModel.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 04/09/26.
//

import Foundation

struct RoomRateModel: Codable {
    let id: String
    let effectiveDate: Date
    let price: Double
    let notes: String
    let localPrice: Double
    let localDiscount: Int
}
