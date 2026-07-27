//
//  OverviewVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 14/07/26.

import UIKit
import FSCalendar

class OverviewVC: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var hotelimgView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var hotelAddressLabel: UILabel!
    @IBOutlet weak var starRatingsLabel: UILabel!
    @IBOutlet weak var editHotelInfoButton: UIButton!
    @IBOutlet weak var publishButton: UIButton!
    @IBOutlet weak var quickStatsLabel: UILabel!
    @IBOutlet weak var totalRoomsView: UIView!
    @IBOutlet weak var totalRoomsTitleLabel: UILabel!
    @IBOutlet weak var totalRoomsCountLabel: UILabel!
    @IBOutlet weak var bookingsView: UIView!
    @IBOutlet weak var bookingsLabel: UILabel!
    @IBOutlet weak var totalBookingsLabel: UILabel!
    @IBOutlet weak var revenueView: UIView!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var totalRevenueCountLabel: UILabel!
    @IBOutlet weak var guestsView: UIView!
    @IBOutlet weak var guestsLabel: UILabel!
    @IBOutlet weak var totalJuestsCountLabel: UILabel!
    @IBOutlet weak var bookingStatusLabel: UILabel!
    @IBOutlet weak var confirmedView: UIView!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var totalConfirmedBookingsCountLabel: UILabel!
    @IBOutlet weak var cancelledView: UIView!
    @IBOutlet weak var cancelledLabel: UILabel!
    @IBOutlet weak var cancelledBookingsCountLabel: UILabel!
    @IBOutlet weak var pendingView: UIView!
    @IBOutlet weak var pendingLabel: UILabel!
    @IBOutlet weak var pendingBookingsCountLabel: UILabel!
    @IBOutlet weak var recentBookingsLabel: UILabel!
    @IBOutlet weak var recentBookingsTableView: UITableView!
    @IBOutlet weak var bookingCalenderLabel: UILabel!
    @IBOutlet weak var bookingCalenderView: UIView!
    @IBOutlet weak var checkInCheckOutTableView: UITableView!
    @IBOutlet weak var noBookingsView: UIView!
    @IBOutlet weak var noBookingOnThisDateLabel: UILabel!
    
    let recentBookings: [Booking] = [
        Booking(id: "BK00884",guestInitials: "TD",guestName: "Testing Demo User",roomNumber: "R00031",checkInDate: "10-Jun-2026",
            status: .pending),
        Booking(id: "BK00882",guestInitials: "MT",guestName: "Mr. Maheswar Reddy",roomNumber: "R00031",checkInDate: "04-Jun-2026",
            status: .pending),
        Booking(id: "BK00877",guestInitials: "TD",guestName: "Testing Demo User",roomNumber: "R00031",checkInDate: "21-May-2026",
            status: .pending),
        Booking(id: "BK00878",guestInitials: "TD",guestName: "Testing Demo User",roomNumber: "R00031",checkInDate: "21-May-2026",
            status: .pending),
        Booking(id: "BK00878",guestInitials: "TD",guestName: "Testing Demo User",roomNumber: "R00031",checkInDate: "21-May-2026",
            status: .pending),
        Booking(id: "BK00878",guestInitials: "TD",guestName: "Testing Demo User",roomNumber: "R00031",checkInDate: "21-May-2026",
            status: .pending)
    ]
    
    var bookingSummaries: [BookingSummary] = [
        BookingSummary(guestName: "Mr. Maheswar Reddy", checkInDate: "2026-02-24", checkOutDate: "2026-03-26"),
        BookingSummary(guestName: "Sarah Jenkins", checkInDate: "2026-03-05", checkOutDate: "2026-03-12"),
        BookingSummary(guestName: "Alessandro Rossi", checkInDate: "2026-03-15", checkOutDate: "2026-03-18"),
        BookingSummary(guestName: "Emma Wilson", checkInDate: "2026-07-10", checkOutDate: "2026-07-14"),
        BookingSummary(guestName: "James Anderson", checkInDate: "2026-07-10", checkOutDate: "2026-07-13")
    ]

    var filteredBookings: [BookingSummary] = []
    
    private let calendar = FSCalendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupCalendar()
        let today = Date()
        calendar.select(today)
        filterBookings(for: today)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendar.frame = bookingCalenderView.bounds
        calendar.setNeedsLayout()
        calendar.layoutIfNeeded()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            // Update calendar frame during rotation
            self.calendar.frame = self.bookingCalenderView.bounds
            self.calendar.setNeedsLayout()
            self.calendar.layoutIfNeeded()
        }, completion: { _ in
            // Ensure calendar is properly sized after rotation
            self.calendar.frame = self.bookingCalenderView.bounds
            self.calendar.setNeedsLayout()
            self.calendar.layoutIfNeeded()
        })
    }
    
    @IBAction func editHotelInfoButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "UpdateHotelDetailsVC") as! UpdateHotelDetailsVC
        present(storyboard, animated: true)
    }
    
    @IBAction func publishButtonAction(_ sender: Any) {
    }
}

// MARK: - TableView Delegate & DataSource
extension OverviewVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == recentBookingsTableView {
            return recentBookings.count
        } else if tableView == checkInCheckOutTableView {
            return filteredBookings.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == recentBookingsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentBookingsTVC") as! RecentBookingsTVC
            let recent = recentBookings[indexPath.row]
            cell.configure(_with: recent)
            return cell
        } else if tableView == checkInCheckOutTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingListTVC") as! BookingListTVC
            let bookingSummary = filteredBookings[indexPath.row]
            cell.configure(_with: bookingSummary)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentBookingsTVC") as! RecentBookingsTVC
            let recent = recentBookings[indexPath.row]
            cell.configure(_with: recent)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == recentBookingsTableView {
            return 64
        } else if tableView == checkInCheckOutTableView {
            return 80
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == recentBookingsTableView {
            guard let headerView = Bundle.main.loadNibNamed("RecentBookingsView", owner: self, options: nil)?.first as? RecentBookingsView else {
                return nil
            }
            return headerView
        }
        return nil
    }
}

// MARK: - UI Setup
extension OverviewVC {
    
    func setUpUI() {
        scrollView.showsVerticalScrollIndicator = false
        publishButton.applyOverviewGradient()
        navigationController?.applyGreenNavigationBar()
        [topView,totalRoomsView,bookingsView,revenueView,guestsView,confirmedView,cancelledView,pendingView].forEach { lightShadow in
            lightShadow.applyLightShadow()
        }
        recentBookingsTableView.register(UINib(nibName: "RecentBookingsTVC", bundle: nil), forCellReuseIdentifier: "RecentBookingsTVC")
        recentBookingsTableView.showsVerticalScrollIndicator = false
        
        checkInCheckOutTableView.register(UINib(nibName: "BookingListTVC", bundle: nil), forCellReuseIdentifier: "BookingListTVC")
        checkInCheckOutTableView.showsVerticalScrollIndicator = false
        checkInCheckOutTableView.sectionHeaderHeight = 0
        
        noBookingsView.isHidden = true
        checkInCheckOutTableView.isHidden = false
    }
    
    func setupCalendar() {
        // Set calendar scope
        calendar.scope = .month
        
        // Set Monday as first day of week (1 = Sunday, 2 = Monday)
        calendar.firstWeekday = 2
        
        // Configure calendar appearance
        calendar.appearance.headerDateFormat = "MMMM yyyy"
        calendar.appearance.headerTitleColor = UIColor(hex: "#1A1A1A")
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18)
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        // Configure weekday appearance
        calendar.appearance.weekdayTextColor = UIColor(hex: "#666666")
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        // Configure date appearance
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 16)
        calendar.appearance.titleDefaultColor = UIColor(hex: "#1A1A1A")
        calendar.appearance.titleWeekendColor = UIColor(hex: "#FF3B30")
        calendar.appearance.titleTodayColor = UIColor(hex: "#22C55E")
        
        // Configure selection colors
        calendar.appearance.selectionColor = UIColor(hex: "#22C55E")
        calendar.appearance.todayColor = UIColor(hex: "#22C55E").withAlphaComponent(0.3)
        calendar.appearance.todaySelectionColor = UIColor(hex: "#22C55E")
        
        // Hide event dots
        calendar.appearance.eventDefaultColor = .clear
        calendar.appearance.eventSelectionColor = .clear
        
        // Configure calendar colors
        calendar.backgroundColor = .clear
        calendar.calendarHeaderView.backgroundColor = .clear
        calendar.calendarWeekdayView.backgroundColor = .clear
        
        // Set delegates
        calendar.delegate = self
        calendar.dataSource = self
        
        // Add calendar to view - using autoresizing mask for frame-based layout
        bookingCalenderView.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints to fill the container view
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: bookingCalenderView.topAnchor),
            calendar.leadingAnchor.constraint(equalTo: bookingCalenderView.leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: bookingCalenderView.trailingAnchor),
            calendar.bottomAnchor.constraint(equalTo: bookingCalenderView.bottomAnchor)
        ])
        
        // Set content hugging priority to allow calendar to fill the container
        calendar.setContentHuggingPriority(.defaultLow, for: .vertical)
        calendar.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        // Reload calendar
        calendar.reloadData()
    }
    
    private func filterBookings(for selectedDate: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        filteredBookings = bookingSummaries.filter { booking in
            guard let checkIn = formatter.date(from: booking.checkInDate),let checkOut = formatter.date(from: booking.checkOutDate) else {
                return false
            }
            return selectedDate >= checkIn && selectedDate <= checkOut
        }

        let hasBookings = !filteredBookings.isEmpty
        checkInCheckOutTableView.isHidden = !hasBookings
        noBookingsView.isHidden = hasBookings
        checkInCheckOutTableView.reloadData()
    }
}

// MARK: - FSCalendar Delegate & DataSource
extension OverviewVC: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        filterBookings(for: date)
        print("Selected date: \(date)")
    }
    
    // This method is called when the calendar's bounds change
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        // When calendar changes its size (e.g., when changing months), update the container
        // The auto layout constraints will handle the resizing
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        } else {
            self.view.layoutIfNeeded()
        }
    }
}
