//
//  ManageLandmarksVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 27/08/26.
//

import UIKit

class ManageLandmarksVC: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var addNewLandmarkButton: UIButton!
    @IBOutlet weak var landmarkSearchBar: UISearchBar!
    @IBOutlet weak var landmarkTableVIew: UITableView!
    @IBOutlet weak var landmarkTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var rowsPerPageLabel: UILabel!
    @IBOutlet weak var rowsPerPageButton: UIButton!
    @IBOutlet weak var totalPagesCountLabel: UILabel!
    @IBOutlet weak var startingPageButton: UIButton!
    @IBOutlet weak var onePageBackwardButton: UIButton!
    @IBOutlet weak var onePageForwardButton: UIButton!
    @IBOutlet weak var lastPageButton: UIButton!
    
    let landmarkList: [LandmarkModel] = [
        LandmarkModel(id: "HL00007",name: "Public Park",type: "Park",distance: 1.5,isActive: true),
        LandmarkModel(id: "HL00008",name: "City Museum",type: "Museum",distance: 2.3,isActive: true),
        LandmarkModel(id: "HL00009",name: "Central Mall",type: "Shopping Mall",distance: 3.1,isActive: true),
        LandmarkModel(id: "HL00010",name: "Railway Station",type: "Transport",distance: 4.2,isActive: true),
        LandmarkModel(id: "HL00011",name: "International Airport",type: "Airport",distance: 8.5,isActive: true),
        LandmarkModel(id: "HL00012",name: "City Hospital",type: "Hospital",distance: 2.8,isActive: false),
        LandmarkModel(id: "HL00013",name: "Central Bus Station",type: "Bus Station",distance: 3.7,isActive: true),
        LandmarkModel(id: "HL00014",name: "Beach",type: "Beach",distance: 6.4,isActive: true),
        LandmarkModel(id: "HL00015",name: "Temple",type: "Religious",distance: 1.9,isActive: false),
        LandmarkModel(id: "HL00016",name: "Cinema",type: "Entertainment",distance: 2.6,isActive: true)
    ]
    private var searchText = ""
    private var selectedLandmarkIndexPath: IndexPath?
    
    private var rowsPerPage = 10
    private var currentPage = 1
    
    private var filteredLandmark: [LandmarkModel] {
        guard !searchText.isEmpty else{
            return landmarkList
        }
     
        return landmarkList.filter { landmarkList in
            landmarkList.id.localizedCaseInsensitiveContains(searchText) ||
            landmarkList.name.localizedCaseInsensitiveContains(searchText) ||
            landmarkList.type.localizedCaseInsensitiveContains(searchText) ||
            String(landmarkList.distance).localizedCaseInsensitiveContains(searchText) ||
            String(landmarkList.isActive).localizedCaseInsensitiveContains(searchText)
        }
    }
    private var totalPages: Int {
        return max( 1,Int(ceil(Double(filteredLandmark.count) / Double(rowsPerPage))))
    }
    private var paginatedLandmark: [LandmarkModel] {
        let startIndex = (currentPage - 1) * rowsPerPage
        guard startIndex < filteredLandmark.count else {
            return []
        }
        let endIndex = min(
            startIndex + rowsPerPage,
            filteredLandmark.count
        )
        return Array(filteredLandmark[startIndex..<endIndex])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func addNewLandmarkButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "AddLandMarkVC") as! AddLandMarkVC
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

extension ManageLandmarksVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginatedLandmark.count
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageLandmarksTVC",for: indexPath) as! ManageLandmarksTVC
        let landMark = paginatedLandmark[indexPath.row]
        cell.configure(with: landMark)
        cell.setSelected(indexPath == selectedLandmarkIndexPath)
        cell.onCheckmarkTapped = { [weak self, weak tableView] in
            guard let self = self else { return }
            let previousIndexPath = self.selectedLandmarkIndexPath
            self.selectedLandmarkIndexPath = indexPath
            var reloadPaths = [indexPath]
            if let previousIndexPath,previousIndexPath != indexPath {reloadPaths.append(previousIndexPath)}
            tableView?.reloadRows(at: reloadPaths, with: .none)
            self.openViewLandmarkScreen(with: landMark)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("ManageLandmarksView", owner: self, options: nil)?.first as? ManageLandmarksView else {
            return nil
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}

extension ManageLandmarksVC {
    func setUpUI() {
        landmarkSearchBar.delegate = self
        landmarkTableVIew.register(UINib(nibName: "ManageLandmarksTVC", bundle: nil), forCellReuseIdentifier: "ManageLandmarksTVC")
        landmarkTableVIew.isScrollEnabled = false
        
        setupRowsPerPageMenu()
        updatePagination()
        addNewLandmarkButton.tintColor = ThemeManager.shared.currentColor
    }
    
    private func updatePagination() {
        let totalCount = filteredLandmark.count
        let startRecord = totalCount == 0 ? 0 : ((currentPage - 1) * rowsPerPage) + 1
        let endRecord = min(currentPage * rowsPerPage, totalCount)
        totalPagesCountLabel.text = "\(startRecord)-\(endRecord) of \(totalCount)"
        startingPageButton.isEnabled = currentPage > 1
        onePageBackwardButton.isEnabled = currentPage > 1
        onePageForwardButton.isEnabled = currentPage < totalPages
        lastPageButton.isEnabled = currentPage < totalPages
        landmarkTableVIew.reloadData()
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
        let totalHeight = (CGFloat(paginatedLandmark.count) * rowHeight) + headerHeight + 20
        landmarkTableViewHeightConstraint.constant = totalHeight
        view.layoutIfNeeded()
    }
    
    private func openViewLandmarkScreen(with landmark: LandmarkModel) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewLandMarkVC") as! ViewLandMarkVC
        vc.landmark = landmark
        vc.onDismiss = { [weak self] in
            guard let self = self else { return }
            if let indexPath = self.selectedLandmarkIndexPath {
                self.selectedLandmarkIndexPath = nil
                self.landmarkTableVIew.reloadRows(at: [indexPath], with: .none)
            }
        }
        present(vc, animated: true)
    }
}


extension ManageLandmarksVC: UISearchBarDelegate {

    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {

        self.searchText = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        // Always start search results from page 1
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
