//
//  UINavigationController+Extension.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 14/07/26.
//

import Foundation
import UIKit

extension UINavigationController {

    func applyGreenNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(
            red: 55.0/255.0,
            green: 157.0/255.0,
            blue: 103.0/255.0,
            alpha: 1.0
        )
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.tintColor = .white
    }
}
