//
//  ManageRoomVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 02/09/26.
//

import UIKit

class ManageRoomVC: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var addNewRoomButton: UIButton!
    @IBOutlet weak var roomSearchBar: UISearchBar!
    @IBOutlet weak var roomListTableView: UITableView!
    @IBOutlet weak var roomListtableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var rowsPerPageLabel: UILabel!
    @IBOutlet weak var rowsPerPageButton: UIButton!
    @IBOutlet weak var totalPagesCountLabel: UILabel!
    @IBOutlet weak var startingPageButton: UIButton!
    @IBOutlet weak var onePageBackwardButton: UIButton!
    @IBOutlet weak var onePageForwardButton: UIButton!
    @IBOutlet weak var lastPageButton: UIButton!
    
    let roomList: [RoomModel] = [
        RoomModel(roomType: "Single Room",bedType: "King",maxAdults: 1,maxChildren: 0,basePrice: 85,breakfast: false,
            roomStatus: "Available",isSelected: true),
        RoomModel(roomType: "Double Room",bedType: "Twin",maxAdults: 2,maxChildren: 1,basePrice: 120,breakfast: false,
            roomStatus: "Available",isSelected: false),
        RoomModel(roomType: "Suite",bedType: "Queen",maxAdults: 3,maxChildren: 2,basePrice: 150,breakfast: false,
            roomStatus: "Available",isSelected: false),
        RoomModel(roomType: "Deluxe",bedType: "Double",maxAdults: 1,maxChildren: 2,basePrice: 180,breakfast: false,
            roomStatus: "Available",isSelected: false)
    ]
    
    private var searchText = ""
    private var selectedRoomsIndexPath: IndexPath?
    
    private var rowsPerPage = 10
    private var currentPage = 1
    
    private var filteredRooms: [RoomModel] {
        guard !searchText.isEmpty else {
            return roomList
        }
        return roomList.filter { room in
            room.roomType.localizedCaseInsensitiveContains(searchText) ||
            room.bedType.localizedCaseInsensitiveContains(searchText) ||
            String(room.maxAdults).localizedCaseInsensitiveContains(searchText) ||
            String(room.maxChildren).localizedCaseInsensitiveContains(searchText) ||
            String(room.basePrice).localizedCaseInsensitiveContains(searchText) ||
            String(room.breakfast).localizedCaseInsensitiveContains(searchText) ||
            room.roomStatus.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    private var totalPages: Int {
        return max( 1,Int(ceil(Double(filteredRooms.count) / Double(rowsPerPage))))
    }
    private var paginatedRooms: [RoomModel] {
        let startIndex = (currentPage - 1) * rowsPerPage
        guard startIndex < filteredRooms.count else {
            return []
        }
        let endIndex = min(
            startIndex + rowsPerPage,
            filteredRooms.count
        )
        return Array(filteredRooms[startIndex..<endIndex])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func addNewRoomButtonAction(_ sender: Any) {
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

extension ManageRoomVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginatedRooms.count
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageRoomTVC",for: indexPath) as! ManageRoomTVC
        let rooms = paginatedRooms[indexPath.row]
        cell.configure(with: rooms)
        cell.setSelected(indexPath == selectedRoomsIndexPath)
        cell.onCheckmarkTapped = { [weak self, weak tableView] in
            guard let self = self else { return }
            let previousIndexPath = self.selectedRoomsIndexPath
            self.selectedRoomsIndexPath = indexPath
            var reloadPaths = [indexPath]
            if let previousIndexPath,previousIndexPath != indexPath {reloadPaths.append(previousIndexPath)}
            tableView?.reloadRows(at: reloadPaths, with: .none)
            self.openViewRoomScreen(with: rooms)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("ManageRoomView", owner: self, options: nil)?.first as? ManageRoomView else {
            return nil
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

extension ManageRoomVC {
    func setUpUI() {
        roomSearchBar.delegate = self
        roomListTableView.register(UINib(nibName: "ManageRoomTVC", bundle: nil), forCellReuseIdentifier: "ManageRoomTVC")
        roomListTableView.isScrollEnabled = false
        
        setupRowsPerPageMenu()
        updatePagination()
        addNewRoomButton.tintColor = ThemeManager.shared.currentColor
    }
    
    private func updatePagination() {
        let totalCount = filteredRooms.count
        let startRecord = totalCount == 0 ? 0 : ((currentPage - 1) * rowsPerPage) + 1
        let endRecord = min(currentPage * rowsPerPage, totalCount)
        totalPagesCountLabel.text = "\(startRecord)-\(endRecord) of \(totalCount)"
        startingPageButton.isEnabled = currentPage > 1
        onePageBackwardButton.isEnabled = currentPage > 1
        onePageForwardButton.isEnabled = currentPage < totalPages
        lastPageButton.isEnabled = currentPage < totalPages
        roomListTableView.reloadData()
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
        let totalHeight = (CGFloat(paginatedRooms.count) * rowHeight) + headerHeight + 25
        roomListtableViewHeightConstraint.constant = totalHeight
        view.layoutIfNeeded()
    }
    
    private func openViewRoomScreen(with room: RoomModel) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewRoomVC") as! ViewRoomVC
//        vc.landmark = room
//        vc.onDismiss = { [weak self] in
//            guard let self = self else { return }
//            if let indexPath = self.selectedRoomsIndexPath {
//                self.selectedRoomsIndexPath = nil
//                self.roomListTableView.reloadRows(at: [indexPath], with: .none)
//            }
//        }
        present(vc, animated: true)
    }
}


extension ManageRoomVC: UISearchBarDelegate {
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
