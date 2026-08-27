//
//  ManageFacilitiesVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 25/08/26.
//

import UIKit

class ManageFacilitiesVC: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var addNewFacilitiesButton: UIButton!
    @IBOutlet weak var facilitiesSearchBar: UISearchBar!
    @IBOutlet weak var facilitiesTableView: UITableView!
    @IBOutlet weak var facilitiesTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var rowsPerPageLabel: UILabel!
    @IBOutlet weak var rowsPerPageButton: UIButton!
    @IBOutlet weak var totalPagesCountLabel: UILabel!
    @IBOutlet weak var startingPageButton: UIButton!
    @IBOutlet weak var onePageBackwardButton: UIButton!
    @IBOutlet weak var onePageForwardButton: UIButton!
    @IBOutlet weak var lastPageButton: UIButton!
    
    let facilityList: [FacilityModel] = [
        FacilityModel(id: "HF00024", facility: "Free Wi-Fi", notes: "High-speed internet available in all rooms and public areas", isActive: true),
        FacilityModel(id: "HF00025", facility: "Luggage Storage", notes: "Available before check-in and after check-out", isActive: true),
        FacilityModel(id: "HF00026", facility: "Tour Desk", notes: "Assistance with booking local tours and attractions", isActive: true),
        FacilityModel(id: "HF00027", facility: "Free Parking", notes: "Complimentary parking for hotel guests", isActive: true),
        FacilityModel(id: "HF00028", facility: "Paid Airport Shuttle", notes: "Available upon request, charges apply", isActive: true),
        FacilityModel(id: "HF00029", facility: "Paid Airport Shuttle", notes: "Available upon request, charges apply", isActive: true), 
        FacilityModel(id: "HF00030", facility: "Restaurant", notes: "Serves breakfast, lunch, and dinner", isActive: true),
        FacilityModel(id: "HF00031", facility: "Coffee Shop", notes: "Freshly brewed coffee and snacks available all day", isActive: true),
        FacilityModel(id: "HF00032", facility: "24h Front Desk", notes: "Round-the-clock assistance for guests", isActive: true),
        FacilityModel(id: "HF00033", facility: "Concierge", notes: "Personalized assistance for reservations and recommendations", isActive: true),
    ];
    
    var selectedIndex = 0
    private var selectedFacilityIndexPath: IndexPath?
    
    private var rowsPerPage = 10
    private var currentPage = 1
    private var totalPages: Int {
        return max( 1,Int(ceil(Double(facilityList.count) / Double(rowsPerPage))))
    }
    private var paginatedFacilities: [FacilityModel] {
        let startIndex = (currentPage - 1) * rowsPerPage
        guard startIndex < facilityList.count else {
            return []
        }
        let endIndex = min(
            startIndex + rowsPerPage,
            facilityList.count
        )
        return Array(facilityList[startIndex..<endIndex])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func addNewFacilitiesButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "AddNewFacilityVC") as! AddNewFacilityVC
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

extension ManageFacilitiesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginatedFacilities.count
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageFacilitiesTVC",for: indexPath) as! ManageFacilitiesTVC
        let facilities = paginatedFacilities[indexPath.row]
        cell.configure(_with: facilities)
        cell.setSelected(indexPath == selectedFacilityIndexPath)
        cell.onCheckmarkTapped = { [weak self, weak tableView] in
            guard let self = self else { return }
            let previousIndexPath = self.selectedFacilityIndexPath
            self.selectedFacilityIndexPath = indexPath
            var reloadPaths = [indexPath]
            if let previousIndexPath,previousIndexPath != indexPath {reloadPaths.append(previousIndexPath)}
            tableView?.reloadRows(at: reloadPaths, with: .none)
            self.openViewFacilitiesScreen(with: facilities)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("ManageFacilitiesView", owner: self, options: nil)?.first as? ManageFacilitiesView else {
            return nil
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}

extension ManageFacilitiesVC {
    func setUpUI() {
        addNewFacilitiesButton.tintColor = ThemeManager.shared.currentColor
        facilitiesTableView.register(UINib(nibName: "ManageFacilitiesTVC", bundle: nil), forCellReuseIdentifier: "ManageFacilitiesTVC")
        facilitiesTableView.isScrollEnabled = false
        
        setupRowsPerPageMenu()
        updatePagination()
    }
    
    private func updatePagination() {
        let totalCount = facilityList.count
        let startRecord = totalCount == 0 ? 0 : ((currentPage - 1) * rowsPerPage) + 1
        let endRecord = min(currentPage * rowsPerPage, totalCount)
        totalPagesCountLabel.text = "\(startRecord)-\(endRecord) of \(totalCount)"
        startingPageButton.isEnabled = currentPage > 1
        onePageBackwardButton.isEnabled = currentPage > 1
        onePageForwardButton.isEnabled = currentPage < totalPages
        lastPageButton.isEnabled = currentPage < totalPages
        facilitiesTableView.reloadData()
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
        facilitiesTableViewHeightConstraint.constant = totalHeight
        view.layoutIfNeeded()
    }
    
    private func openViewFacilitiesScreen(with facility: FacilityModel) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewFacilityVC") as! ViewFacilityVC
        vc.facility = facility
        vc.onDismiss = { [weak self] in
            guard let self = self else { return }
            if let indexPath = self.selectedFacilityIndexPath {
                self.selectedFacilityIndexPath = nil
                self.facilitiesTableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        present(vc, animated: true)
    }
}
