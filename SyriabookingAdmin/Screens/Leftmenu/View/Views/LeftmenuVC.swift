//
//  LeftmenuVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 14/07/26.
//

import UIKit

class LeftmenuVC: UIViewController {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var leftmenuListTableView: UITableView!
    
    private var selectedSubmenuIndex: Int?{
        return SidebarManager.shared.selectedManageRoomsSubmenu
    }
    
    let sidebarMenus: [SidebarMenuItem] = [
        SidebarMenuItem(title: "Overview",icon: "square.grid.2x2"),
        SidebarMenuItem(title: "Hotel Invoices",icon: "doc.text"),
        SidebarMenuItem(title: "Manage Bookings",icon: "calendar"),
        SidebarMenuItem(title: "Manage Reviews",icon: "star"),
        SidebarMenuItem(title: "Manage Discounts",icon: "tag"),
        SidebarMenuItem(title: "Manage Facilities",icon: "wrench.and.screwdriver"),
        SidebarMenuItem(title: "Manage Landmarks",icon: "location"),
        SidebarMenuItem(title: "Manage Policies",icon: "doc"),
        SidebarMenuItem(title: "Manage Images",icon: "photo"),
        SidebarMenuItem(title: "Manage Rooms",icon: "door.left.hand.open")
    ]
    private let manageRoomsSubmenus: [SidebarMenuItem] = [

           SidebarMenuItem(
               title: "Manage Room Rates",
               icon: "dollarsign.circle"
           ),

           SidebarMenuItem(
               title: "Manage Room Images",
               icon: "photo"
           ),

           SidebarMenuItem(
               title: "Manage Room Facilities",
               icon: "wrench.and.screwdriver"
           )
       ]

       // MARK: - State

       var selectedIndex = 0

       private var isManageRoomsExpanded: Bool {
           return SidebarManager.shared.isManageRoomsExpanded
       }

    var onDismiss: (() -> Void)?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        selectedIndex = SidebarManager.shared.selectedMenu.rawValue
        NotificationCenter.default.addObserver(self, selector: #selector(manageRoomsSubMenuChanged), name: .manageRoomsSubmenuChanged, object: nil)
        leftmenuListTableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func manageRoomsSubMenuChanged(){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else{
                return
            }
            self.leftmenuListTableView.reloadData()
        }
    }
    
    @IBAction func diasmissButtonAction(_ sender: Any) {
        onDismiss?()
    }
}

extension LeftmenuVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isManageRoomsExpanded{
            return sidebarMenus.count + manageRoomsSubmenus.count
        }
        return sidebarMenus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftmenuTVC") as! LeftmenuTVC
        if indexPath.row < sidebarMenus.count {
            let menuItems = sidebarMenus[indexPath.row]
            let isSelected: Bool
            if indexPath.row == SidebarMenu.manageRooms.rawValue, selectedSubmenuIndex != nil{
                isSelected = false
            }else{
                isSelected = indexPath.row == selectedIndex
            }
            
            cell.setSubmenuStyle(false)
            cell.configure(with: menuItems,isSelected: isSelected)
            return cell
        }
        
        let submenuIndex = indexPath.row - sidebarMenus.count
        let submnuItems = manageRoomsSubmenus[submenuIndex]
        let isSelected = selectedSubmenuIndex == submenuIndex
        cell.setSubmenuStyle(true)
        cell.configure(with: submnuItems, isSelected: isSelected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row >= sidebarMenus.count {
            let submenuIndex = indexPath.row - sidebarMenus.count
            selectedIndex = SidebarMenu.manageRooms.rawValue
            SidebarManager.shared.selectedMenu = .manageRooms
            SidebarManager.shared.selectedManageRoomsSubmenu = submenuIndex
            SidebarManager.shared.expandManageRooms()
            
            tableView.reloadData()
            handleManageRoomsSubmenu( submenuIndex )
            return
        }
        
        selectedIndex = indexPath.row

        let selectedMenu = SidebarMenu(rawValue: indexPath.row) ?? .overview
        // Save selected menu
        SidebarManager.shared.selectedMenu =
            selectedMenu
        
        if selectedMenu == .manageRooms {
            SidebarManager.shared.selectedManageRoomsSubmenu = nil
            SidebarManager.shared.selectManageRooms()
        }else{
            SidebarManager.shared.collapseManageRooms()
        }

        tableView.reloadData()

        switch SidebarManager.shared.selectedMenu {

        case .overview:
            let vc = UIStoryboard(name: "Overview", bundle: nil)
                .instantiateViewController(withIdentifier: "OverviewVC") as! OverviewVC
            navigationController?.pushViewController(vc, animated: true)
            onDismiss?()
        case .hotelInvoices:
            let vc = UIStoryboard(name: "HotelInvoice", bundle: nil)
                .instantiateViewController(withIdentifier: "HotelInvoiceVC") as! HotelInvoiceVC
            navigationController?.pushViewController(vc, animated: true)
            onDismiss?()
        case .manageBookings:
            let vc = UIStoryboard(name: "ManageBookings", bundle: nil).instantiateViewController(withIdentifier: "ManageBookingsVC") as! ManageBookingsVC
            navigationController?.pushViewController(vc, animated: true)
            onDismiss?()
        case .manageReviews:
            let vc = UIStoryboard(name: "ManageReviews", bundle: nil).instantiateViewController(withIdentifier: "ManageReviewsVC") as! ManageReviewsVC
            navigationController?.pushViewController(vc, animated: true)
            onDismiss?()
        case .manageDiscounts:
            let vc = UIStoryboard(name: "ManageDiscounts", bundle: nil).instantiateViewController(withIdentifier: "ManageDiscountsVC") as! ManageDiscountsVC
            navigationController?.pushViewController(vc, animated: true)
            onDismiss?()
        case .manageFacilities:
            let vc = UIStoryboard(name: "ManageFacilities", bundle: nil).instantiateViewController(withIdentifier: "ManageFacilitiesVC") as! ManageFacilitiesVC
            navigationController?.pushViewController(vc, animated: true)
            onDismiss?()
        case .manageLandmarks:
            let vc = UIStoryboard(name: "ManageLandmarks", bundle: nil).instantiateViewController(withIdentifier: "ManageLandmarksVC") as! ManageLandmarksVC
            navigationController?.pushViewController(vc, animated: true)
            onDismiss?()
        case .managePolicies:
            let vc = UIStoryboard(name: "ManagePolicies", bundle: nil).instantiateViewController(withIdentifier: "ManagePoliciesVC") as! ManagePoliciesVC
            navigationController?.pushViewController(vc, animated: true)
            onDismiss?()
        case .manageImages:
            let vc = UIStoryboard(name: "ManageImages", bundle: nil).instantiateViewController(withIdentifier: "ManageImagesVC") as! ManageImagesVC
            navigationController?.pushViewController(vc, animated: true)
            onDismiss?()
        case .manageRooms:
            let vc = UIStoryboard(name: "ManageRoom", bundle: nil).instantiateViewController(withIdentifier: "ManageRoomVC") as! ManageRoomVC
            navigationController?.pushViewController(vc, animated: true)
            onDismiss?()
        }
    }
}

extension LeftmenuVC {
    private func handleManageRoomsSubmenu(_ index: Int){
        
        SidebarManager.shared.selectedMenu = .manageRooms
        SidebarManager.shared.selectedManageRoomsSubmenu = index
        SidebarManager.shared.expandManageRooms()
        
        switch index {
        case 0:

                    let vc = UIStoryboard(
                        name: "ManageRate",
                        bundle: nil
                    )
                    .instantiateViewController(
                        withIdentifier: "ManageRateVC"
                    )

                    navigationController?.pushViewController(
                        vc,
                        animated: true
                    )

                    onDismiss?()

                case 1:

                    let vc = UIStoryboard(
                        name: "ManageImages",
                        bundle: nil
                    )
                    .instantiateViewController(
                        withIdentifier: "ManageImagesVC"
                    ) as! ManageImagesVC

                    navigationController?.pushViewController(
                        vc,
                        animated: true
                    )

                    onDismiss?()

                case 2:

                    let vc = UIStoryboard(
                        name: "ManageRoomFacilities",
                        bundle: nil
                    )
                    .instantiateViewController(
                        withIdentifier: "ManageRoomFacilitiesVC"
                    ) as! ManageRoomFacilitiesVC

                    navigationController?.pushViewController(
                        vc,
                        animated: true
                    )
            onDismiss?()
            
        default:
            break
        }
    }
}

extension LeftmenuVC {
    func setUpUI() {
        backView.applyLightShadow()
        backView.layer.cornerRadius = 10
        backView.layer.maskedCorners = [
            .layerMaxXMinYCorner,
            .layerMaxXMaxYCorner
        ]
        backView.clipsToBounds = false
        backView.layer.masksToBounds = false
        
        leftmenuListTableView.register(UINib(nibName: "LeftmenuTVC", bundle: nil), forCellReuseIdentifier: "LeftmenuTVC")
    }
}
