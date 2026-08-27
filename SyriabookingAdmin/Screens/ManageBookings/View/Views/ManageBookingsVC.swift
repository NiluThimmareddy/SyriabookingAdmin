//
//  ManageBookingsVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 30/07/26.

import UIKit

class ManageBookingsVC: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var addNewBookingsButton: UIButton!
    @IBOutlet weak var searchBookings: UISearchBar!
    @IBOutlet weak var bookingStatusCollectionView: UICollectionView!
    @IBOutlet weak var booingStatusScrollView: UIScrollView!
    @IBOutlet weak var bookingStatusInsideScrollView: UIView!
    @IBOutlet weak var bookingStatusListTableView: UITableView!
    @IBOutlet weak var rowsPerPageLabel: UILabel!
    @IBOutlet weak var rowsPerPageButton: UIButton!
    @IBOutlet weak var totalPagesCountLabel: UILabel!
    @IBOutlet weak var startingPageButton: UIButton!
    @IBOutlet weak var onePageBackwardButton: UIButton!
    @IBOutlet weak var onePageForwardButton: UIButton!
    @IBOutlet weak var lastPageButton: UIButton!
    @IBOutlet weak var bookingStatusListScrollViewHeightConstraint: NSLayoutConstraint!
    
    let bookingStatusArray: [BookingStatusModel] = [
        BookingStatusModel(title: "PENDING",iconName: "doc.text"),
        BookingStatusModel(title: "CONFIRMED",iconName: "checkmark.circle.fill"),
        BookingStatusModel(title: "CHECK-IN",iconName: "calendar.badge.checkmark"),
        BookingStatusModel(title: "CHECK-OUT",iconName: "rectangle.portrait.and.arrow.right"),
        BookingStatusModel(title: "CANCELLED",iconName: "xmark.circle.fill"),
        BookingStatusModel(title: "NO SHOW",iconName: "person.circle.fill")
    ]
    
    let bookings: [BookingModel] = [
        BookingModel(bookingId: "BK00498",guestName: "Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "23-Jan-2026",checkOutDate: "23-Jan-2026",amount: 110,discount: 5.5,netTotal: 104.5,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00518",guestName: "Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "18-Feb-2026",checkOutDate: "18-Feb-2026",amount: 100,discount: 10,netTotal: 90,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00559",guestName:"Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "24-Feb-2026",checkOutDate: "24-Feb-2026",amount: 110,discount: 5.5,netTotal: 104.5,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00677",guestName:"Testing Demo User",guestPhone: "90000000",roomId: "R00032",checkInDate: "26-Feb-2026",checkOutDate: "26-Feb-2026",amount: 140,discount: 0,netTotal: 140,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00715",guestName:"Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "02-Mar-2026",checkOutDate: "02-Mar-2026",amount: 100,discount: 10,netTotal: 90,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00727",guestName:"Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "03-Mar-2026",checkOutDate: "03-Mar-2026",amount: 100,discount: 10,netTotal: 90,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00806",guestName:"Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "11-Mar-2026",checkOutDate: "11-Mar-2026",amount: 100,discount: 10,netTotal: 90,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00807",guestName:"Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "11-Mar-2026",checkOutDate: "11-Mar-2026",amount: 110,discount: 5.5,netTotal: 104.5,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00823",guestName:"Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "13-Mar-2026",checkOutDate: "13-Mar-2026",amount: 100,discount: 10,netTotal: 90,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00877",guestName: "Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "21-May-2026",checkOutDate: "23-May-2026",amount: 200,discount: 20,netTotal: 180,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00878",guestName: "Rahul Sharma",guestPhone: "9876543210",roomId: "R00015",checkInDate: "25-May-2026",checkOutDate: "27-May-2026",amount: 250,discount: 25,netTotal: 225,status: "Confirmed",bookingType: "Local"),
        BookingModel(bookingId: "BK00879",guestName: "Priya Reddy",guestPhone: "9123456789",roomId: "R00018",checkInDate: "28-May-2026",checkOutDate: "30-May-2026",amount: 300,discount: 30,netTotal: 270,status: "Confirmed",bookingType: "Local"),
        BookingModel(bookingId: "BK00880",guestName: "John Smith",guestPhone: "9988776655",roomId: "R00022",checkInDate: "01-Jun-2026",checkOutDate: "04-Jun-2026",amount: 450,discount: 50,netTotal: 400,status: "Check-In",bookingType: "International"),
        BookingModel(bookingId: "BK00881",guestName: "Ananya Patel",guestPhone: "9001112233",roomId: "R00012",checkInDate: "03-Jun-2026",checkOutDate: "05-Jun-2026",amount: 220,discount: 10,netTotal: 210,status: "Pending",bookingType: "Local"),
        BookingModel(bookingId: "BK00882",guestName: "David Miller",guestPhone: "9556677889",roomId: "R00025",checkInDate: "05-Jun-2026",checkOutDate: "08-Jun-2026",amount: 520,discount: 40,netTotal: 480,status: "Check-Out",bookingType: "International"),
        BookingModel(bookingId: "BK00883",guestName: "Sneha Verma",guestPhone: "9887766554",roomId: "R00009",checkInDate: "07-Jun-2026",checkOutDate: "09-Jun-2026",amount: 180,discount: 0,netTotal: 180,status: "Confirmed",bookingType: "Local"),
        BookingModel(bookingId: "BK00884",guestName: "Michael Brown",guestPhone: "9776655443",roomId: "R00027",checkInDate: "10-Jun-2026",checkOutDate: "14-Jun-2026",amount: 600,discount: 60,netTotal: 540,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00885",guestName: "Kiran Kumar",guestPhone: "9665544332",roomId: "R00006",checkInDate: "12-Jun-2026",checkOutDate: "13-Jun-2026",amount: 120,discount: 5,netTotal: 115,status: "Cancelled",bookingType: "Local"),
        BookingModel(bookingId: "BK00886",guestName: "Emily Johnson",guestPhone: "9554433221",roomId: "R00029",checkInDate: "15-Jun-2026",checkOutDate: "18-Jun-2026",amount: 480,discount: 20,netTotal: 460,status: "Confirmed",bookingType: "International"),
        BookingModel(bookingId: "BK00887",guestName: "Arjun Singh",guestPhone: "9443322110",roomId: "R00014",checkInDate: "17-Jun-2026",checkOutDate: "19-Jun-2026",amount: 260,discount: 15,netTotal: 245,status: "Check-In",bookingType: "Local"),
        BookingModel(bookingId: "BK00888",guestName: "Neha Gupta",guestPhone: "9332211009",roomId: "R00019",checkInDate: "20-Jun-2026",checkOutDate: "22-Jun-2026",amount: 290,discount: 10,netTotal: 280,status: "Pending",bookingType: "Local"),
        BookingModel(bookingId: "BK00889",guestName: "Chris Evans",guestPhone: "9221100998",roomId: "R00035",checkInDate: "22-Jun-2026",checkOutDate: "26-Jun-2026",amount: 700,discount: 100,netTotal: 600,status: "Confirmed",bookingType: "International"),
        BookingModel(bookingId: "BK00890",guestName: "Karun Nair",guestPhone: "9110099887",roomId: "R00016",checkInDate: "25-Jun-2026",checkOutDate: "28-Jun-2026",amount: 350,discount: 25,netTotal: 325,status: "Check-Out",bookingType: "Local"),
        BookingModel(bookingId: "BK00891",guestName: "Robert Wilson",guestPhone: "9009988776",roomId: "R00038",checkInDate: "28-Jun-2026",checkOutDate: "01-Jul-2026",amount: 550,discount: 50,netTotal: 500,status: "Confirmed",bookingType: "International"),
        BookingModel(bookingId: "BK00892",guestName: "Lakshmi Devi",guestPhone: "9898989898",roomId: "R00011",checkInDate: "02-Jul-2026",checkOutDate: "04-Jul-2026",amount: 240,discount: 20,netTotal: 220,status: "Pending",bookingType: "Local"),
        BookingModel(bookingId: "BK00893",guestName: "Daniel Thomas",guestPhone: "9787878787",roomId: "R00041",checkInDate: "05-Jul-2026",checkOutDate: "08-Jul-2026",amount: 620,discount: 70,netTotal: 550,status: "No Show",bookingType: "International"),
        BookingModel(bookingId: "BK00894",guestName: "Aisha Khan",guestPhone: "9676767676",roomId: "R00020",checkInDate: "09-Jul-2026",checkOutDate: "11-Jul-2026",amount: 280,discount: 15,netTotal: 265,status: "Confirmed",bookingType: "Local"),
        BookingModel(bookingId: "BK00895",guestName: "Vikram Rao",guestPhone: "9565656565",roomId: "R00017",checkInDate: "12-Jul-2026",checkOutDate: "14-Jul-2026",amount: 320,discount: 20,netTotal: 300,status: "Check-In",bookingType: "Local"),
        BookingModel(bookingId: "BK00896",guestName: "Sophia Lee",guestPhone: "9454545454",roomId: "R00044",checkInDate: "15-Jul-2026",checkOutDate: "18-Jul-2026",amount: 680,discount: 80,netTotal: 600,status: "Confirmed",bookingType: "International"),
        BookingModel(bookingId: "BK00897",guestName: "Manoj Kumar",guestPhone: "9343434343",roomId: "R00008",checkInDate: "18-Jul-2026",checkOutDate: "20-Jul-2026",amount: 210,discount: 10,netTotal: 200,status: "Cancelled",bookingType: "Local"),
        BookingModel(bookingId: "BK00897",guestName: "Manoj Kumar",guestPhone: "9343434343",roomId: "R00008",checkInDate: "18-Jul-2026",checkOutDate: "20-Jul-2026",amount: 210,discount: 10,netTotal: 200,status: "Cancelled",bookingType: "Local")
    ]
    
    var selectedIndex = 0
    private var selectedBookingIndexPath: IndexPath?
    
    // Pagination
    private var rowsPerPage = 10
    private var currentPage = 1
    private var totalPages: Int {
        return max( 1,Int(ceil(Double(filteredBookings.count) / Double(rowsPerPage))))
    }
    private var paginatedBookings: [BookingModel] {
        let startIndex = (currentPage - 1) * rowsPerPage
        guard startIndex < filteredBookings.count else {
            return []
        }
        let endIndex = min(
            startIndex + rowsPerPage,
            filteredBookings.count
        )
        return Array(filteredBookings[startIndex..<endIndex])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bookingStatusCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    @IBAction func addNewBookingsButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "AddNewBookingVC") as! AddNewBookingVC
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

extension ManageBookingsVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookingStatusArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ManageBookingStatusCVC", for: indexPath) as! ManageBookingStatusCVC
        let bookingStatus = bookingStatusArray[indexPath.row]
        let count: Int
        switch indexPath.item {
        case 0:
            count = bookingCount(for: "Pending")
        case 1:
            count = bookingCount(for: "Confirmed")
        case 2:
            count = bookingCount(for: "Check-In")
        case 3:
            count = bookingCount(for: "Check-Out")
        case 4:
            count = bookingCount(for: "Cancelled")
        case 5:
            count = bookingCount(for: "No Show")
        default:
            count = 0
        }
        let updatedStatus = BookingStatusModel(title: bookingStatus.title,iconName: bookingStatus.iconName)
        cell.statusCountLabel.text = "\(count)"
        cell.configure(_with: updatedStatus,isSelected: selectedIndex == indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 4
        let spacing: CGFloat = 12
        let sectionInset: CGFloat = 20
        let availableWidth = collectionView.bounds.width - (sectionInset * 2) - ((columns - 1) * spacing)
        let cellWidth = floor(availableWidth / columns)
        return CGSize(width: cellWidth, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView,didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        currentPage = 1
        collectionView.reloadData()
        updatePagination()
    }
}

extension ManageBookingsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginatedBookings.count
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageBookingStatusTVC",for: indexPath) as! ManageBookingStatusTVC
        let booking = paginatedBookings[indexPath.row]
        cell.configure(_with: booking)
        cell.setSelected(indexPath == selectedBookingIndexPath)
        cell.onCheckmarkTapped = { [weak self, weak tableView] in
            guard let self = self else { return }
            let previousIndexPath = self.selectedBookingIndexPath
            self.selectedBookingIndexPath = indexPath
            var reloadPaths = [indexPath]
            if let previousIndexPath,previousIndexPath != indexPath {reloadPaths.append(previousIndexPath)}
            tableView?.reloadRows(at: reloadPaths, with: .none)
            self.openViewBookingScreen(with: booking)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("ManageBookingStatusView", owner: self, options: nil)?.first as? ManageBookingStatusView else {
            return nil
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}


extension ManageBookingsVC {
    func setUpUI() {
        addNewBookingsButton.tintColor = ThemeManager.shared.currentColor
        bookingStatusCollectionView.register(UINib(nibName: "ManageBookingStatusCVC", bundle: nil), forCellWithReuseIdentifier: "ManageBookingStatusCVC")
        if let layout = bookingStatusCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
            layout.minimumLineSpacing = 30
            layout.minimumInteritemSpacing = 12
        }
        bookingStatusCollectionView.isScrollEnabled = false
        
        bookingStatusListTableView.register(UINib(nibName: "ManageBookingStatusTVC", bundle: nil), forCellReuseIdentifier: "ManageBookingStatusTVC")
        bookingStatusListTableView.isScrollEnabled = false
        
        setupRowsPerPageMenu()
        updatePagination()
    }
    
    private func updatePagination() {
        let totalCount = filteredBookings.count
        let startRecord = totalCount == 0 ? 0 : ((currentPage - 1) * rowsPerPage) + 1
        let endRecord = min(currentPage * rowsPerPage, totalCount)
        totalPagesCountLabel.text = "\(startRecord)-\(endRecord) of \(totalCount)"
        startingPageButton.isEnabled = currentPage > 1
        onePageBackwardButton.isEnabled = currentPage > 1
        onePageForwardButton.isEnabled = currentPage < totalPages
        lastPageButton.isEnabled = currentPage < totalPages
        bookingStatusListTableView.reloadData()
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
        let totalHeight = (CGFloat(paginatedBookings.count) * rowHeight) + headerHeight + 20
        bookingStatusListScrollViewHeightConstraint.constant = totalHeight
        view.layoutIfNeeded()
    }
    
    private var filteredBookings: [BookingModel] {
        switch selectedIndex {
        case 0: // PENDING
            return bookings.filter {
                $0.status.lowercased() == "pending"
            }
        case 1: // CONFIRMED
            return bookings.filter {
                $0.status.lowercased() == "confirmed"
            }
        case 2: // CHECK-IN
            return bookings.filter {
                $0.status.lowercased() == "check-in"
            }
        case 3: // CHECK-OUT
            return bookings.filter {
                $0.status.lowercased() == "check-out"
            }
        case 4: // CANCELLED
            return bookings.filter {
                $0.status.lowercased() == "cancelled"
            }
        case 5: // NO SHOW
            return bookings.filter {
                $0.status.lowercased() == "no show"
            }
        default:
            return bookings
        }
    }
    
    private func bookingCount(for status: String) -> Int {
        return bookings.filter {
            $0.status.lowercased() == status.lowercased()
        }.count
    }
    
    private func openViewBookingScreen(with booking: BookingModel) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewBookingVC") as! ViewBookingVC
        vc.booking = booking
        vc.onDismiss = { [weak self] in
            guard let self = self else { return }
            if let indexPath = self.selectedBookingIndexPath {
                self.selectedBookingIndexPath = nil
                self.bookingStatusListTableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        present(vc, animated: true)
    }
}
