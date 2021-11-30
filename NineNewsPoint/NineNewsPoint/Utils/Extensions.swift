//
//  Extensions.swift
//  NineNewsPoint
//
//  Created by Animesh Mishra on 26/11/21.
//

import UIKit
// MARK: - UIColor extension
extension UIColor {
    /// get Appearance Color on basis of Dark and Light Mode
    /// The style associated with the user interface.
    public static func getAppearanceColor(_ color: UIColor) -> UIColor {
        UIColor.init { (trait) -> UIColor in
            switch color {
            case .black:
                return trait.userInterfaceStyle == .dark ? .systemPink : .black
            default:
                return trait.userInterfaceStyle == .dark ? .systemBlue : .gray
            }
        }
    }
}

// MARK: - Date extension
extension Date {
    /// format date in Australia/Sydney time zone
    /// Returns a string representation of a given date formatted using the receiver’s current settings.
    /// - Returns: String
    func getDateTimeString() -> String {
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = Constants.DateFormat
        dayTimePeriodFormatter.timeZone = TimeZone(abbreviation: Constants.AustraliaSydney)
        return dayTimePeriodFormatter.string(from: self)
    }
}

// MARK: - UIViewController extension
extension UIViewController {
    func showAlert(title: String? = nil,
                   message: String? = nil,
                   buttonTitle:String? = nil,
                   completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: completion)
    }
}


// MARK: - UIWindow extension
extension UIWindow {
    /// Check whether device is landscape or Portraits
    ///A Boolean value indicating whether the user interface is currently presented in a landscape orientation.
    static var isLandscape: Bool {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? false
    }
}
