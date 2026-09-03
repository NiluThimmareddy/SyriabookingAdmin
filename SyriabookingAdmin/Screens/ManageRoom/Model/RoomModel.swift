//
//  RoomModel.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 02/09/26.
//

import Foundation
import UIKit

struct RoomModel {

    let roomType: String
    let bedType: String
    let maxAdults: Int
    let maxChildren: Int
    let basePrice: Int
    let breakfast: Bool
    let roomStatus: String
    var isSelected: Bool
}
