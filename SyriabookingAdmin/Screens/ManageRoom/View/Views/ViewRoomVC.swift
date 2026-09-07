//
//  ViewRoomVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 02/09/26.
//

import UIKit
enum ManageRoomOption {
    case rates
    case images
    case facilities
}

class ViewRoomVC: UIViewController {
    
    @IBOutlet weak var eyeIconImgView: UIImageView!
    @IBOutlet weak var viewRoomIDLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var basicInfoView: UIView!
    @IBOutlet weak var basicInfoButton: UIButton!
    @IBOutlet weak var occupancyView: UIView!
    @IBOutlet weak var occupancyButton: UIButton!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var imagesButton: UIButton!
    @IBOutlet weak var ratebutton: UIButton!
    @IBOutlet weak var facilitiesButton: UIButton!
    
    var onManageRoomOptionSelected: ((ManageRoomOption) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func basicInfoButtonAction(_ sender: Any) {
    }
    
    @IBAction func occupancyButtonAction(_ sender: Any) {
    }
    
    @IBAction func detailsButtonAction(_ sender: Any) {
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
    }
    
    @IBAction func imagesButtonAction(_ sender: Any) {
        onManageRoomOptionSelected?(.images)
        
    }
    
    @IBAction func rateButtonAction(_ sender: Any) {
        onManageRoomOptionSelected?(.rates)
    }
    
    @IBAction func facilitiesButtonAction(_ sender: Any) {
        onManageRoomOptionSelected?(.facilities)
    }
    
//    private func openViewRoomScreen(with room: RoomModel) {
//
//        guard let vc = storyboard?.instantiateViewController(
//            withIdentifier: "ViewRoomVC"
//        ) as? ViewRoomVC else {
//            return
//        }
//
//        vc.modalPresentationStyle = .overFullScreen
//
//        vc.onManageRoomOptionSelected = { [weak self, weak vc] option in
//
//            guard let self = self else {
//                return
//            }
//
//            // Keep Manage Rooms submenu expanded
//            SidebarManager.shared.expandManageRooms()
//
//            // First dismiss ViewRoomVC
//            vc?.dismiss(animated: true) { [weak self] in
//
//                guard let self = self else {
//                    return
//                }
//
//                switch option {
//
//                case .rates:
//
//                    guard let ratesVC = UIStoryboard(
//                        name: "ManageRate",
//                        bundle: nil
//                    ).instantiateViewController(
//                        withIdentifier: "ManageRateVC"
//                    ) as? ManageRateVC else {
//                        return
//                    }
//
//                    self.navigationController?.pushViewController(
//                        ratesVC,
//                        animated: true
//                    )
//
//
//                case .images:
//
//                    guard let imagesVC = UIStoryboard(
//                        name: "ManageRoomImage",
//                        bundle: nil
//                    ).instantiateViewController(
//                        withIdentifier: "ManageRoomImageVC"
//                    ) as? ManageRoomImageVC else {
//                        return
//                    }
//
//                    self.navigationController?.pushViewController(
//                        imagesVC,
//                        animated: true
//                    )
//
//
//                case .facilities:
//
//                    guard let facilitiesVC = UIStoryboard(
//                        name: "ManageRoomFacilities",
//                        bundle: nil
//                    ).instantiateViewController(
//                        withIdentifier: "ManageRoomFacilitiesVC"
//                    ) as? ManageRoomFacilitiesVC else {
//                        return
//                    }
//
//                    self.navigationController?.pushViewController(
//                        facilitiesVC,
//                        animated: true
//                    )
//                }
//            }
//        }
//
//        present(
//            vc,
//            animated: true
//        )
//    }
    
//
//    private func openViewRoomScreen(with room: RoomModel) {
//
//        guard let vc = storyboard?.instantiateViewController(
//            withIdentifier: "ViewRoomVC"
//        ) as? ViewRoomVC else {
//            return
//        }
//        
//        vc.modalPresentationStyle = .overFullScreen
//        
//        
//
//        vc.onManageRoomOptionSelected = { [weak self] option in
//
//            guard let self = self else {
//                return
//            }
//
//            // Expand Manage Rooms submenu
//            SidebarManager.shared.expandManageRooms()
//
//            switch option {
//
//            case .rates:
//
//                guard let ratesVC = UIStoryboard(
//                    name: "ManageRate",
//                    bundle: nil
//                ).instantiateViewController(
//                    withIdentifier: "ManageRateVC"
//                ) as? ManageRateVC else {
//                    return
//                }
//
//                self.navigationController?.pushViewController(
//                    ratesVC,
//                    animated: true
//                )
//
//
//            case .images:
//
//                guard let imagesVC = UIStoryboard(
//                    name: "ManageRoomImage",
//                    bundle: nil
//                ).instantiateViewController(
//                    withIdentifier: "ManageRoomImageVC"
//                ) as? ManageRoomImageVC else {
//                    return
//                }
//
//                self.navigationController?.pushViewController(
//                    imagesVC,
//                    animated: true
//                )
//
//
//            case .facilities:
//
//                guard let facilitiesVC = UIStoryboard(
//                    name: "ManageRoomFacilities",
//                    bundle: nil
//                ).instantiateViewController(
//                    withIdentifier: "ManageRoomFacilitiesVC"
//                ) as? ManageRoomFacilitiesVC else {
//                    return
//                }
//
//                self.navigationController?.pushViewController(
//                    facilitiesVC,
//                    animated: true
//                )
//            }
//        }
//
//        // Present ViewRoomVC
//        present(
//            vc,
//            animated: true
//        )
//    }
}
