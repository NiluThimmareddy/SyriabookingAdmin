//
//  ManageRoomFacilitiesVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 03/09/26.
//

import UIKit

class ManageRoomFacilitiesVC: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var addNewFacilityButton: UIButton!
    @IBOutlet weak var facilitySearchBar: UISearchBar!
    @IBOutlet weak var facilitylistTableView: UITableView!
    @IBOutlet weak var facilityListTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var rowsPerPageLabel: UILabel!
    @IBOutlet weak var rowsPerPageButton: UIButton!
    @IBOutlet weak var totalPagesCountLabel: UILabel!
    @IBOutlet weak var startingPageButton: UIButton!
    @IBOutlet weak var onePageBackwardButton: UIButton!
    @IBOutlet weak var onePageForwardButton: UIButton!
    @IBOutlet weak var lastPageButton: UIButton!

    let roomFacilities: [RoomFacility] = [
        RoomFacility(id: "RF00346", facility: "WIRED INTERNET", description: "Lorem"),
        RoomFacility(id: "RF00347", facility: "TV", description: "42 inch Smart TV"),
        RoomFacility(id: "RF00348", facility: "MINI BAR", description: "Stocked daily")
    ]
    
    private var searchText = ""
    private var selectedRoomFacilityIndexPath: IndexPath?
    
    private var rowsPerPage = 10
    private var currentPage = 1
    
    
    private var filteredFacilityList : [RoomFacility] {
        guard !searchText.isEmpty else {
            return roomFacilities
        }
        
        return roomFacilities.filter { facility in
            facility.id.localizedCaseInsensitiveContains(searchText) ||
            facility.facility.localizedCaseInsensitiveContains(searchText) ||
            facility.description.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    private var totalPages: Int {
        return max( 1,Int(ceil(Double(filteredFacilityList.count) / Double(rowsPerPage))))
    }
    private var paginatedFacilities: [RoomFacility] {
        let startIndex = (currentPage - 1) * rowsPerPage
        guard startIndex < filteredFacilityList.count else {
            return []
        }
        let endIndex = min(
            startIndex + rowsPerPage,
            filteredFacilityList.count
        )
        return Array(filteredFacilityList[startIndex..<endIndex])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func addNewFacilityButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "AddRoomFacilityVC") as! AddRoomFacilityVC
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

extension ManageRoomFacilitiesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginatedFacilities.count
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomFacilityTVC",for: indexPath) as! RoomFacilityTVC
        let roomFacilities = paginatedFacilities[indexPath.row]
        cell.configure(_with: roomFacilities)
        cell.setSelected(indexPath == selectedRoomFacilityIndexPath)
        cell.onCheckmarkTapped = { [weak self, weak tableView] in
            guard let self = self else { return }
            let previousIndexPath = self.selectedRoomFacilityIndexPath
            self.selectedRoomFacilityIndexPath = indexPath
            var reloadPaths = [indexPath]
            if let previousIndexPath,previousIndexPath != indexPath {reloadPaths.append(previousIndexPath)}
            tableView?.reloadRows(at: reloadPaths, with: .none)
            self.openViewRoomFacilitiesScreen(with: roomFacilities)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("RoomFacilityView", owner: self, options: nil)?.first as? RoomFacilityView else {
            return nil
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}

extension ManageRoomFacilitiesVC {
    func setUpUI() {
        addNewFacilityButton.tintColor = ThemeManager.shared.currentColor
        facilitySearchBar.delegate = self
        facilitylistTableView.register(UINib(nibName: "RoomFacilityTVC", bundle: nil), forCellReuseIdentifier: "RoomFacilityTVC")
        facilitylistTableView.isScrollEnabled = false
        
        setupRowsPerPageMenu()
        updatePagination()
    }
    
    private func updatePagination() {
        let totalCount = filteredFacilityList.count
        let startRecord = totalCount == 0 ? 0 : ((currentPage - 1) * rowsPerPage) + 1
        let endRecord = min(currentPage * rowsPerPage, totalCount)
        totalPagesCountLabel.text = "\(startRecord)-\(endRecord) of \(totalCount)"
        startingPageButton.isEnabled = currentPage > 1
        onePageBackwardButton.isEnabled = currentPage > 1
        onePageForwardButton.isEnabled = currentPage < totalPages
        lastPageButton.isEnabled = currentPage < totalPages
        facilitylistTableView.reloadData()
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
        let totalHeight = (CGFloat(paginatedFacilities.count) * rowHeight) + headerHeight + 20
        facilityListTableViewHeightConstraint.constant = totalHeight
        view.layoutIfNeeded()
    }
    
    private func openViewRoomFacilitiesScreen(with facility: RoomFacility) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewRoomFacilityVC") as! ViewRoomFacilityVC
        vc.facility = facility
        vc.onDismiss = { [weak self] in
            guard let self = self else { return }
            if let indexPath = self.selectedRoomFacilityIndexPath {
                self.selectedRoomFacilityIndexPath = nil
                self.facilitylistTableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        present(vc, animated: true)
    }
}

extension ManageRoomFacilitiesVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar,textDidChange searchText: String) {
        self.searchText = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
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
