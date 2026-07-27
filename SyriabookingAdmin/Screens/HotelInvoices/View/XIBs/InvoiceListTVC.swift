//
//  InvoiceListTVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 27/07/26.
//

import UIKit

class InvoiceListTVC: UITableViewCell {

    @IBOutlet weak var invoiceNumberLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var paidDateLabel: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    
    var onViewTapped: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func viewButtonAction(_ sender: Any) {
        onViewTapped?()
    }
    
    func configure(_with invoice: Invoice) {
        invoiceNumberLabel.text = invoice.invoiceNo
        periodLabel.text = invoice.period
        statusLabel.text = invoice.status.rawValue
        totalAmountLabel.text = "\(invoice.totalAmount)\(invoice.currency)"
        paidDateLabel.text = invoice.paidDate ?? "-"
        dueDateLabel.text = invoice.dueDate
        statusLabel.layer.cornerRadius = 6
        statusLabel.clipsToBounds = true
        statusLabel.textAlignment = .center

        switch invoice.status {
        case .draft:
            statusLabel.backgroundColor = UIColor(hex: "F3F4F6")
            statusLabel.textColor = UIColor(hex: "4B5563")
        case .canceled:
            statusLabel.backgroundColor = UIColor(hex: "FEF2F2")
            statusLabel.textColor = UIColor(hex: "B91C1C")
        case .disputed:
            statusLabel.backgroundColor = UIColor(hex: "FFF7ED")
            statusLabel.textColor = UIColor(hex: "C2410C")
        case .paid:
            statusLabel.backgroundColor = UIColor(hex: "F0FDF4")
            statusLabel.textColor = UIColor(hex: "15803D")
        case .partiallyPaid:
            statusLabel.backgroundColor = UIColor(hex: "EFF6FF")
            statusLabel.textColor = UIColor(hex: "1D4ED8")
        }
    }
}
