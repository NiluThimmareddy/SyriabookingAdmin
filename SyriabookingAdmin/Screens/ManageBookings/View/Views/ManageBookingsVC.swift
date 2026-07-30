//
//  ManageBookingsVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 30/07/26.
//

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
    @IBOutlet weak var bookingStatusScrollViewHeightConstraint: NSLayoutConstraint!
    
    
    
    let bookingStatusArray: [BookingStatusModel] = [
        BookingStatusModel(title: "PENDING",count: "99+",iconName: "doc.text"),
        BookingStatusModel(title: "CONFIRMED",count: "1",iconName: "checkmark.circle.fill"),
        BookingStatusModel(title: "CHECK-IN",count: "5",iconName: "calendar.badge.checkmark"),
        BookingStatusModel(title: "CHECK-OUT",count: "0",iconName: "rectangle.portrait.and.arrow.right"),
        BookingStatusModel(title: "CANCELLED",count: "31",iconName: "xmark.circle.fill"),
        BookingStatusModel(title: "NO SHOW",count: "1",iconName: "person.circle.fill")
    ]
    
    let bookings: [BookingModel] = [
        BookingModel(bookingId: "BK00498",guestName: "Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "23-Jan-2026",checkOutDate: "23-Jan-2026",amount: 110,discount: 5.5,
            netTotal: 104.5,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00518",guestName: "Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "18-Feb-2026",checkOutDate: "18-Feb-2026",amount: 100,discount: 10,
            netTotal: 90,status: "Pending",
            bookingType: "International"),
        BookingModel(bookingId: "BK00559",guestName:"Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "24-Feb-2026",checkOutDate: "24-Feb-2026",amount: 110,discount: 5.5,
            netTotal: 104.5,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00677",guestName:"Testing Demo User",guestPhone: "90000000",roomId: "R00032",checkInDate: "26-Feb-2026",checkOutDate: "26-Feb-2026",amount: 140,discount: 0,
            netTotal: 140,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00715",guestName:"Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "02-Mar-2026",checkOutDate: "02-Mar-2026",amount: 100,discount: 10,
            netTotal: 90,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00727",guestName:"Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "03-Mar-2026",checkOutDate: "03-Mar-2026",amount: 100,discount: 10,
            netTotal: 90,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00806",guestName:"Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "11-Mar-2026",checkOutDate: "11-Mar-2026",amount: 100,discount: 10,
            netTotal: 90,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00807",guestName:"Testing Demo User",guestPhone: "90000000",roomId: "R00031",checkInDate: "11-Mar-2026",checkOutDate: "11-Mar-2026",amount: 110,discount: 5.5,
            netTotal: 104.5,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00823",guestName:"Testing Demo User",guestPhone: "90000000",
            roomId: "R00031",checkInDate: "13-Mar-2026",checkOutDate: "13-Mar-2026",amount: 100,discount: 10,netTotal: 90,status: "Pending",bookingType: "International"),
        BookingModel(bookingId: "BK00877",guestName: "Testing Demo User",guestPhone: "90000000",
            roomId: "R00031",checkInDate: "21-May-2026",checkOutDate: "23-May-2026",amount: 200,discount: 20,netTotal: 180,status: "Pending",bookingType: "International")
    ]
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookingStatusCollectionView.register(UINib(nibName: "ManageBookingStatusCVC", bundle: nil), forCellWithReuseIdentifier: "ManageBookingStatusCVC")
        if let layout = bookingStatusCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
            layout.minimumLineSpacing = 30
            layout.minimumInteritemSpacing = 12
        }
        bookingStatusCollectionView.isScrollEnabled = false
        
        bookingStatusListTableView.register(UINib(nibName: "ManageBookingStatusTVC", bundle: nil), forCellReuseIdentifier: "ManageBookingStatusTVC")
        bookingStatusListTableView.isScrollEnabled = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bookingStatusCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    @IBAction func addNewBookingsButtonAction(_ sender: Any) {
    }
    
    @IBAction func startingPageButtonAction(_ sender: Any) {
    }
    
    @IBAction func onePageBackwardButtonAction(_ sender: Any) {
    }
    
    @IBAction func onePageFarwardButtonAction(_ sender: Any) {
    }
    
    @IBAction func lastPageButtonAction(_ sender: Any) {
    }
    
}


extension ManageBookingsVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookingStatusArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ManageBookingStatusCVC", for: indexPath) as! ManageBookingStatusCVC
        let bookingStatus = bookingStatusArray[indexPath.row]
        cell.configure(_with: bookingStatus,isSelected: selectedIndex == indexPath.item)
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
        collectionView.reloadData()
    }
}

extension ManageBookingsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageBookingStatusTVC") as! ManageBookingStatusTVC
        let bookings = bookings[indexPath.row]
        cell.configure(_with: bookings)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
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
