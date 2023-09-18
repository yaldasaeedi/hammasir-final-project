//
//  Notifications.swift
//  hammasir-final-project
//
//  Created by Helen Besharatian on 6/22/1402 AP.
//

import Foundation
import UIKit

struct Notifications {
    
    // notif baraye esm gozashtan ro safar
    static var tripName : String?

    static func showYesNoNotification(on viewController: UIViewController) {
        let alertController = UIAlertController(title: "Notification", message: "Do you want to proceed?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            // Handle "Yes" button action
            print("Yes button tapped")
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in
            // Handle "No" button action
            print("No button tapped")
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    // ...
    static func showNameInputNotification(on viewController: UIViewController) {
        
        print("its in ShowName...")
        let alertController = UIAlertController(title: "Notification", message: "Please enter your trip name:", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            textField.placeholder = "trip Name"
        }

        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if let nameTextField = alertController.textFields?.first, let name = nameTextField.text {
                Notifications.tripName = name
                print("User's trip name is \(name)")
            }
        }

        let noAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            print("Cancel button tapped")
        }

        alertController.addAction(okAction)
        alertController.addAction(noAction)

        print("it's about to present the alert")
        viewController.present(alertController, animated: true, completion: nil)
    }

    
}
