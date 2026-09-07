//
//  SidebarManager.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 23/07/26.
//

import Foundation
final class SidebarManager {
    static let shared = SidebarManager()

    private init() {}
    
    var selectedMenu: SidebarMenu = .overview
    var selectedManageRoomsSubmenu : Int? = nil
    var isManageRoomsSelected: Bool = false
    private(set) var isManageRoomsExpanded: Bool = false
    
    func expandManageRooms() {
        isManageRoomsSelected = true
        isManageRoomsExpanded = true
        NotificationCenter.default.post(name: .manageRoomsSubmenuChanged, object: nil)
    }
    
    func collapseManageRooms(){
        isManageRoomsExpanded = false
        isManageRoomsSelected = false
        selectedManageRoomsSubmenu = nil
        NotificationCenter.default.post(
            name: .manageRoomsSubmenuChanged,
            object: nil
        )
    }
    
    func selectManageRooms() {
        selectedMenu = .manageRooms
        isManageRoomsSelected = true
        isManageRoomsExpanded = false
        selectedManageRoomsSubmenu = nil

        NotificationCenter.default.post(
            name: .manageRoomsSubmenuChanged,
            object: nil
        )
    }
}

extension Notification.Name {

    static let manageRoomsSubmenuChanged =
        Notification.Name("manageRoomsSubmenuChanged")
}
