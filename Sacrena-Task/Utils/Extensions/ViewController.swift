//
//  ViewController.swift
//  Sacrena-Task
//
//  Created by Gulam Ali on 16/09/24.
//

import Foundation
import UIKit

extension UIViewController {
    // Function to show alert with a message
    func showAlert(withMessage message: String) {
        // Create an instance of UIAlertController with title, message and style
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        // Add an OK action that will dismiss the alert when tapped
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert controller
        self.present(alert, animated: true, completion: nil)
    }
}
