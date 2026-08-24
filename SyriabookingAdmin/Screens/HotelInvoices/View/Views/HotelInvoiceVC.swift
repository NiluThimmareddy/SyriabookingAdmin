//
//  HotelInvoiceVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 23/07/26.

import UIKit

class HotelInvoiceVC: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var invoiceTitleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var draftTitleLabel: UILabel!
    @IBOutlet weak var draftCountLabel: UILabel!
    @IBOutlet weak var disputedTitleLabel: UILabel!
    @IBOutlet weak var disputedCountLabel: UILabel!
    @IBOutlet weak var partiallyPaidTitleLabel: UILabel!
    @IBOutlet weak var partiallyPaidCountLabel: UILabel!
    @IBOutlet weak var paidTitleLabel: UILabel!
    @IBOutlet weak var paidCountLabel: UILabel!
    @IBOutlet weak var approvedTitleLabel: UILabel!
    @IBOutlet weak var approvedCountLabel: UILabel!
    @IBOutlet weak var sentTitleLabel: UILabel!
    @IBOutlet weak var sentCountLabel: UILabel!
    @IBOutlet weak var cancelledTitleLabel: UILabel!
    @IBOutlet weak var cancelledCountLabel: UILabel!
    @IBOutlet weak var allInvoiceLabel: UILabel!
    @IBOutlet weak var allInvoiceCountLabel: UILabel!
    @IBOutlet weak var invoiceListTableview: UITableView!
    @IBOutlet weak var invoiceListTableviewHeightConstraint: NSLayoutConstraint!
    
    
    let invoices: [Invoice] = [
        Invoice(invoiceNo: "INV000030",period: "2025-12",status: .draft,totalAmount: 785.40,currency: "USD",dueDate: "06 Jan 2026",paidDate: nil ?? "-"),
        Invoice(invoiceNo: "INV000030",period: "2025-12",status: .canceled,totalAmount: 240.40,currency: "USD",dueDate: "22 Nov 2026",paidDate: nil ?? "-"),
        Invoice(invoiceNo: "INV000030",period: "2025-12",status: .disputed,totalAmount: 240.40,currency: "USD",dueDate: "22 Nov 2026",paidDate: nil ?? "-"),
        Invoice(invoiceNo: "INV000030",period: "2025-12",status: .paid,totalAmount: 240.40,currency: "USD",dueDate: "22 Nov 2026",paidDate: "15 Nov 2026"),
        Invoice(invoiceNo: "INV000030",period: "2025-12",status: .partiallyPaid,totalAmount: 263.60,currency: "USD",
            dueDate: "22 Nov 2026",paidDate: nil ?? "-"),
        Invoice(invoiceNo: "INV000030",period: "2025-12",status: .draft,totalAmount: 263.60,currency: "USD",dueDate: "22 Nov 2026",paidDate: nil ?? "-"),
        Invoice(invoiceNo: "INV000030",period: "2025-12",status: .draft,totalAmount: 263.60,currency: "USD",dueDate: "22 Nov 2026",paidDate: nil ?? "-"),
        Invoice(invoiceNo: "INV000030",period: "2025-12",status: .draft,totalAmount: 785.40,currency: "USD",dueDate: "15 Nov 2025",paidDate: nil ?? "-"),
        Invoice(invoiceNo: "INV000030",period: "2025-12",status: .paid,totalAmount: 2677.50,currency: "USD",dueDate: "15 Nov 2025",paidDate: nil ?? "-"),
        Invoice(invoiceNo: "INV000030",period: "2025-12",status: .disputed,totalAmount: 3570.00,currency: "USD",dueDate: "15 Nov 2025",paidDate: "15 Nov 2026"),
        Invoice(invoiceNo: "INV000030",period: "2025-12",status: .disputed,totalAmount: 3570.00,currency: "USD",dueDate: "15 Nov 2025",paidDate: "15 Nov 2026"),
        Invoice(invoiceNo: "INV000030",period: "2025-12",status: .paid,totalAmount: 2677.50,currency: "USD",dueDate: "15 Nov 2025",paidDate: "15 Nov 2026")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.showsVerticalScrollIndicator = false
        invoiceListTableview.register(UINib(nibName: "InvoiceListTVC", bundle: nil), forCellReuseIdentifier: "InvoiceListTVC")
        invoiceListTableview.isScrollEnabled = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        invoiceListTableview.layoutIfNeeded()
        invoiceListTableviewHeightConstraint.constant = invoiceListTableview.contentSize.height
    }
    
}

extension HotelInvoiceVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceListTVC") as! InvoiceListTVC
        let invoice = invoices[indexPath.row]
        cell.configure(_with: invoice)
        cell.onViewTapped = { [weak self] in
            guard let self = self else { return }
            let invoice = self.invoices[indexPath.row]
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HotelViewVC") as! HotelViewVC
            vc.selectedInvoice = invoice
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("InvoiceView", owner: self, options: nil)?.first as? InvoiceView else {
            return nil
        }
        return headerView
    }
}
