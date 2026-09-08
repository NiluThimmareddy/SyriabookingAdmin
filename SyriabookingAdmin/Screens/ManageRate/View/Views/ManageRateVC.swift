//
//  ManageRateVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 03/09/26.
//

import UIKit

class ManageRateVC: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var addNewRateButton: UIButton!
    @IBOutlet weak var rateSearchbar: UISearchBar!
    @IBOutlet weak var rateListTableView: UITableView!
    @IBOutlet weak var rateListTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var rowsPerPageLabel: UILabel!
    @IBOutlet weak var rowsPerPageButton: UIButton!
    @IBOutlet weak var totalPagesCountLabel: UILabel!
    @IBOutlet weak var startingPageButton: UIButton!
    @IBOutlet weak var onePageBackwardButton: UIButton!
    @IBOutlet weak var onePageForwardButton: UIButton!
    @IBOutlet weak var lastPageButton: UIButton!
    
    let roomRates: [RoomRateModel] = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        return [
            RoomRateModel(
                id: "RR00046",
                effectiveDate: formatter.date(from: "17-08-2025 11:06") ?? Date(),
                price: 140.00,
                discount: 10,
                notes: "For 2 person Only",
                localPrice: 10000.00,
                localDiscount: 15
            ),
            RoomRateModel(
                id: "RR00099",
                effectiveDate: formatter.date(from: "26-08-2025 08:05") ?? Date(),
                price: 95.00,
                discount: 5,
                notes: "For 2 Adult, 1 Child",
                localPrice: 110000.00,
                localDiscount: 10
            )
        ]
    }()
    
    private var searchText = ""
    private var selectedRatesIndexPath: IndexPath?
    
    private var rowsPerPage = 10
    private var currentPage = 1
    
    private var filteredRates: [RoomRateModel] {
        guard !searchText.isEmpty else {
            return roomRates
        }
        return roomRates.filter { room in
            room.notes.localizedCaseInsensitiveContains(searchText) ||
            room.id.localizedCaseInsensitiveContains(searchText) ||
            String(room.price).localizedCaseInsensitiveContains(searchText) ||
            String(room.localPrice).localizedCaseInsensitiveContains(searchText) ||
            String(room.localDiscount).localizedCaseInsensitiveContains(searchText)
        }
    }
    
    private var totalPages: Int {
        return max(1, Int(ceil(Double(filteredRates.count) / Double(rowsPerPage))))
    }
    
    private var paginatedRates: [RoomRateModel] {
        let startIndex = (currentPage - 1) * rowsPerPage
        guard startIndex < filteredRates.count else {
            return []
        }
        let endIndex = min(startIndex + rowsPerPage, filteredRates.count)
        return Array(filteredRates[startIndex..<endIndex])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func addNewRateButtonAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddNewRoomRateVC") as! AddNewRoomRateVC
        present(vc, animated: true)
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
    
    @IBAction func onePageForwardButtonAction(_ sender: Any) {
        guard currentPage < totalPages else { return }
        currentPage += 1
        updatePagination()
    }
    
    @IBAction func lastPageButtonAction(_ sender: Any) {
        currentPage = totalPages
        updatePagination()
    }
}

extension ManageRateVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginatedRates.count
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageRateTVC",for: indexPath) as! ManageRateTVC
        let rates = paginatedRates[indexPath.row]
        cell.configure(_with: rates)
        cell.setSelected(indexPath == selectedRatesIndexPath)
        cell.onCheckmarkTapped = { [weak self, weak tableView] in
            guard let self = self else { return }
            let previousIndexPath = self.selectedRatesIndexPath
            self.selectedRatesIndexPath = indexPath
            var reloadPaths = [indexPath]
            if let previousIndexPath,previousIndexPath != indexPath {reloadPaths.append(previousIndexPath)}
            tableView?.reloadRows(at: reloadPaths, with: .none)
            self.openViewRoomRateScreen(with: rates)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("ManageRateView", owner: self, options: nil)?.first as? ManageRateView else {
            return nil
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

extension ManageRateVC {
    func setUpUI() {
        rateSearchbar.delegate = self
        rateListTableView.register(UINib(nibName: "ManageRateTVC", bundle: nil), forCellReuseIdentifier: "ManageRateTVC")
        rateListTableView.isScrollEnabled = false
        
        setupRowsPerPageMenu()
        updatePagination()
        addNewRateButton.tintColor = ThemeManager.shared.currentColor
    }
    
    private func updatePagination() {
        let totalCount = filteredRates.count
        let startRecord = totalCount == 0 ? 0 : ((currentPage - 1) * rowsPerPage) + 1
        let endRecord = min(currentPage * rowsPerPage, totalCount)
        totalPagesCountLabel.text = "\(startRecord)-\(endRecord) of \(totalCount)"
        startingPageButton.isEnabled = currentPage > 1
        onePageBackwardButton.isEnabled = currentPage > 1
        onePageForwardButton.isEnabled = currentPage < totalPages
        lastPageButton.isEnabled = currentPage < totalPages
        rateListTableView.reloadData()
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
        let headerHeight: CGFloat = 60
        let totalHeight = (CGFloat(paginatedRates.count) * rowHeight) + headerHeight + 25
        rateListTableViewHeightConstraint.constant = totalHeight
        view.layoutIfNeeded()
    }
    
    private func openViewRoomRateScreen(with roomRate: RoomRateModel) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewRoomRateVC") as! ViewRoomRateVC
        vc.roomRate = roomRate
        vc.onDismiss = { [weak self] in
            guard let self = self else { return }
            if let indexPath = self.selectedRatesIndexPath {
                self.selectedRatesIndexPath = nil
                self.rateListTableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        present(vc, animated: true)
    }
}

extension ManageRateVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        currentPage = 1
        updatePagination()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchText = ""
        currentPage = 1
        updatePagination()
        searchBar.resignFirstResponder()
    }
}

