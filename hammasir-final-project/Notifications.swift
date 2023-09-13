//
//  Notifications.swift
//  hammasir-final-project
//
//  Created by Helen Besharatian on 6/22/1402 AP.
//

import Foundation
import UIKit

class Notifications: UIViewController {
    
    // ...

    func showYesNoNotification() {
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
        
        present(alertController, animated: true, completion: nil)
    }
    
    // ...
    
}
