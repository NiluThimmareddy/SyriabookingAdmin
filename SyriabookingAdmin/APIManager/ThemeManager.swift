//
//  ThemeManager.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 29/07/26.
//



import UIKit

extension Notification.Name {
    static let themeChanged = Notification.Name("themeChanged")
}

final class ThemeManager {

    static let shared = ThemeManager()

    private init() {
        loadColor()
    }

    private let colorKey = "SelectedThemeColor"

    private(set) var currentColor: UIColor = UIColor(
        red: 55.0/255.0,
        green: 157.0/255.0,
        blue: 103.0/255.0,
        alpha: 1.0
    )

   
    
    func setThemeColor(_ color: UIColor) {

        currentColor = color

        if let data = try? NSKeyedArchiver.archivedData(
            withRootObject: color,
            requiringSecureCoding: false
        ) {
            UserDefaults.standard.set(data, forKey: colorKey)
        }

        NotificationCenter.default.post(name: .themeChanged, object: nil)
    }

    private func loadColor() {

        guard let data = UserDefaults.standard.data(forKey: colorKey),
              let color = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor else {
            return
        }

        currentColor = color
    }
}

//import UIKit
//
//extension Notification.Name {
//    static let themeDidChange = Notification.Name("themeDidChange")
//}
//
//final class ThemeManager {
//
//    static let shared = ThemeManager()
//
//    private let colorKey = "SelectedThemeColor"
//
//    private init() {}
//
//    var primaryColor: UIColor {
//        get {
//            guard let data = UserDefaults.standard.data(forKey: colorKey),
//                  let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data) else {
//                return .systemBlue
//            }
//            return color
//        }
//
//        set {
//            if let data = try? NSKeyedArchiver.archivedData(withRootObject: newValue,
//                                                           requiringSecureCoding: false) {
//                UserDefaults.standard.set(data, forKey: colorKey)
//            }
//
//            NotificationCenter.default.post(name: .themeDidChange, object: nil)
//        }
//    }
//}
