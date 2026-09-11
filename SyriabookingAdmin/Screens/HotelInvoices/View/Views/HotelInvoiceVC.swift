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
    @IBOutlet weak var invoiceIconImageView: UIImageView!
    @IBOutlet var invoiceStatusButton: [UIButton]!
    @IBOutlet weak var draftView: UIView!
    @IBOutlet weak var disputedView: UIView!
    @IBOutlet weak var partiallyPaidView: UIView!
    @IBOutlet weak var paidView: UIView!
    @IBOutlet weak var approvedView: UIView!
    @IBOutlet weak var sentView: UIView!
    @IBOutlet weak var cancelledView: UIView!
    @IBOutlet weak var allView: UIView!
    
    
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
    
    private var searchText = ""
    private var selectedIndex = 7

    private var filteredInvoices: [Invoice] {
        let statusFilteredInvoices: [Invoice]
        switch selectedIndex {
        case 0:
            statusFilteredInvoices = invoices.filter {
                $0.status == .draft
            }
        case 1:
            statusFilteredInvoices = invoices.filter {
                $0.status == .disputed
            }
        case 2:
            statusFilteredInvoices = invoices.filter {
                $0.status == .partiallyPaid
            }
        case 3:
            statusFilteredInvoices = invoices.filter {
                $0.status == .paid
            }
        case 4:
            statusFilteredInvoices = invoices.filter {
                $0.status == .approved
            }
        case 5:
            statusFilteredInvoices = invoices.filter {
                $0.status == .sent
            }
        case 6:
            statusFilteredInvoices = invoices.filter {
                $0.status == .canceled
            }
        case 7:
            statusFilteredInvoices = invoices
        default:
            statusFilteredInvoices = invoices
        }

        guard !searchText.isEmpty else {
            return statusFilteredInvoices
        }

        return statusFilteredInvoices.filter { invoice in

            invoice.invoiceNo.localizedCaseInsensitiveContains(searchText) ||
            invoice.period.localizedCaseInsensitiveContains(searchText) ||
            invoice.status.rawValue.localizedCaseInsensitiveContains(searchText) ||
            String(invoice.totalAmount).localizedCaseInsensitiveContains(searchText) ||
            invoice.dueDate.localizedCaseInsensitiveContains(searchText) ||
            (invoice.paidDate?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        applyTheme()
    }
    
    override func applyTheme() {
        super.applyTheme()
        let themeColor = ThemeManager.shared.currentColor
        invoiceIconImageView.tintColor = themeColor
        updateInvoiceStatusViewSelection()
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableViewHeight()
    }
    
    private func updateTableViewHeight() {
        invoiceListTableview.layoutIfNeeded()
        invoiceListTableviewHeightConstraint.constant = invoiceListTableview.contentSize.height
    }
    
    @IBAction func hotelInvoiceStatusButtonAction(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        selectedIndex = button.tag
        updateInvoiceStatusViewSelection()
        invoiceListTableview.reloadData()
        DispatchQueue.main.async { [weak self] in
            self?.updateTableViewHeight()
        }
    }
}

extension HotelInvoiceVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredInvoices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceListTVC") as! InvoiceListTVC
        let invoice = filteredInvoices[indexPath.row]
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


extension HotelInvoiceVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        invoiceListTableview.reloadData()
        
        DispatchQueue.main.async{
            self.updateTableViewHeight()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchText = ""
        
        invoiceListTableview.reloadData()
        
        DispatchQueue.main.async{
            self.updateTableViewHeight()
        }
        
        searchBar.resignFirstResponder()
    }
}


extension HotelInvoiceVC {
    func setUpUI() {
        scrollView.showsVerticalScrollIndicator = false
        invoiceListTableview.register(UINib(nibName: "InvoiceListTVC", bundle: nil),forCellReuseIdentifier: "InvoiceListTVC")
        invoiceListTableview.isScrollEnabled = false
        searchBar.delegate = self

        for (index, button) in invoiceStatusButton.enumerated() {
            button.tag = index
        }
    }
    
    private func updateInvoiceStatusViewSelection() {
        let statusViews: [UIView] = [draftView,disputedView,partiallyPaidView,paidView,approvedView,sentView,cancelledView,allView]
        for (index, view) in statusViews.enumerated() {
            if index == selectedIndex {
                view.layer.borderWidth = 1
                view.layer.borderColor = ThemeManager.shared.currentColor.cgColor
            } else {
                view.layer.borderWidth = 0
                view.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
}
