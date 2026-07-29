//
//  Invoice.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 27/07/26.
//

import Foundation

struct Invoice: Identifiable, Codable {
    let id = UUID()
    let invoiceNo: String
    let period: String
    let status: InvoiceStatus
    let totalAmount: Double
    let currency: String
    let dueDate: String
    let paidDate: String?

    enum CodingKeys: String, CodingKey {
        case invoiceNo
        case period
        case status
        case totalAmount
        case currency
        case dueDate
        case paidDate
    }
}

enum InvoiceStatus: String, Codable {
    case draft = "Draft"
    case canceled = "Cancelled"
    case disputed = "Disputed"
    case paid = "Paid"
    case partiallyPaid = "Partially Paid"
    case approved = "Approved"
}
