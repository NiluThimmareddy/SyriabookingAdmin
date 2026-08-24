//
//  ManageDiscountsVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 24/08/26.
//

import UIKit

class ManageDiscountsVC: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var addNewDiscountButton: UIButton!
    @IBOutlet weak var discountsSearchBar: UISearchBar!
    @IBOutlet weak var discountsListTableView: UITableView!
    @IBOutlet weak var discountsListTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rowsPerPageLabel: UILabel!
    @IBOutlet weak var rowsPerPageButton: UIButton!
    @IBOutlet weak var totalPagesCountLabel: UILabel!
    @IBOutlet weak var startingPageButton: UIButton!
    @IBOutlet weak var onePageBackwardButton: UIButton!
    @IBOutlet weak var onePageForwardButton: UIButton!
    @IBOutlet weak var lastPageButton: UIButton!
    
    let discountList: [DiscountModel] = [
        DiscountModel(id: "HD00005",name: "Happy New Year Discount",type: "Percentage",value: 5, isActive: false, activeDate: nil),
        DiscountModel(id: "HD00006",name: "Summer Special Discount",type: "Percentage",value: 10, isActive: true, activeDate: "26-Aug-2026"),
        DiscountModel(id: "HD00007",name: "Weekend Discount",type: "Percentage",value: 15, isActive: false, activeDate: nil),
        DiscountModel(id: "HD00008",name: "Festival Discount",type: "Percentage",value: 20, isActive: true, activeDate: "28-Aug-2026"),
        DiscountModel(id: "HD00009",name: "New Customer Discount",type: "Percentage",value: 10, isActive: false, activeDate: "28-Aug-2026")
    ]
    
    var selectedIndex = 0
    private var selectedDiscountIndexPath: IndexPath?
    
    private var rowsPerPage = 10
    private var currentPage = 1
    private var totalPages: Int {
        return max( 1,Int(ceil(Double(discountList.count) / Double(rowsPerPage))))
    }
    private var paginatedDiscounts: [DiscountModel] {
        let startIndex = (currentPage - 1) * rowsPerPage
        guard startIndex < discountList.count else {
            return []
        }
        let endIndex = min(
            startIndex + rowsPerPage,
            discountList.count
        )
        return Array(discountList[startIndex..<endIndex])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func addNewDiscountButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "AddDiscountVC") as! AddDiscountVC
        present(storyboard, animated: true)
    }
    
    @IBAction func startingPageButtonAction(_ sender: Any) {
        currentPage = 1
        updatePagination()
    }
    
    @IBAction func onePageBackwardButtonAction(_ sender: Any) {
        guard currentPage > 1 else { return }
        currentPage -= 1
        updatePagination()
    }
    
    @IBAction func onePageFarwardButtonAction(_ sender: Any) {
        guard currentPage < totalPages else { return }
        currentPage += 1
        updatePagination()
    }
    
    @IBAction func lastPageButtonAction(_ sender: Any) {
        currentPage = totalPages
        updatePagination()
    }
    

}

extension ManageDiscountsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginatedDiscounts.count
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageDiscountsTVC",for: indexPath) as! ManageDiscountsTVC
        let discount = paginatedDiscounts[indexPath.row]
        cell.configure(with: discount)
        cell.setSelected(indexPath == selectedDiscountIndexPath)
        cell.onCheckmarkTapped = { [weak self, weak tableView] in
            guard let self = self else { return }
            let previousIndexPath = self.selectedDiscountIndexPath
            self.selectedDiscountIndexPath = indexPath
            var reloadPaths = [indexPath]
            if let previousIndexPath,previousIndexPath != indexPath {reloadPaths.append(previousIndexPath)}
            tableView?.reloadRows(at: reloadPaths, with: .none)
            self.openViewDiscountScreen(with: discount)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("ManageDiscountsView", owner: self, options: nil)?.first as? ManageDiscountsView else {
            return nil
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}

extension ManageDiscountsVC {
    func setUpUI() {
        discountsListTableView.register(UINib(nibName: "ManageDiscountsTVC", bundle: nil), forCellReuseIdentifier: "ManageDiscountsTVC")
        discountsListTableView.isScrollEnabled = false
        
        setupRowsPerPageMenu()
        updatePagination()
    }
    
    private func updatePagination() {
        let totalCount = discountList.count
        let startRecord = totalCount == 0 ? 0 : ((currentPage - 1) * rowsPerPage) + 1
        let endRecord = min(currentPage * rowsPerPage, totalCount)
        totalPagesCountLabel.text = "\(startRecord)-\(endRecord) of \(totalCount)"
        startingPageButton.isEnabled = currentPage > 1
        onePageBackwardButton.isEnabled = currentPage > 1
        onePageForwardButton.isEnabled = currentPage < totalPages
        lastPageButton.isEnabled = currentPage < totalPages
        discountsListTableView.reloadData()
        DispatchQueue.main.async {
            self.updateTableHeight()
        }
    }
    
    private func setupRowsPerPageMenu() {
        let options = [10, 20, 30, 40]
        let actions = options.map { value in
            UIAction(title: "\(value)") { [weak self] _ in
                guard let self = self else { return }
                self.rowsPerPage = value
                self.currentPage = 1
                self.rowsPerPageButton.setTitle("\(value)", for: .normal)
                self.updatePagination()
            }
        }
        rowsPerPageButton.menu = UIMenu(title: "", children: actions)
        rowsPerPageButton.showsMenuAsPrimaryAction = true
        rowsPerPageButton.setTitle("10", for: .normal)
    }
    
    private func updateTableHeight() {
        let rowHeight: CGFloat = 53.5
        let headerHeight: CGFloat = 45
        let totalHeight = (CGFloat(paginatedDiscounts.count) * rowHeight) + headerHeight + 20
        discountsListTableViewHeightConstraint.constant = totalHeight
        view.layoutIfNeeded()
    }
    
    private func openViewDiscountScreen(with discount: DiscountModel) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewDiscountVC") as! ViewDiscountVC
        vc.discount = discount
        vc.onDismiss = { [weak self] in
            guard let self = self else { return }
            if let indexPath = self.selectedDiscountIndexPath {
                self.selectedDiscountIndexPath = nil
                self.discountsListTableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        present(vc, animated: true)
    }
}
