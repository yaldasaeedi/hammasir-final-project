//
//  StartingTripFlow.swift
//  hammasir-final-project
//
//  Created by yalda saeedi on 6/27/1402 AP.
//

import Foundation

class StartingTripFlow{
    
    func showNameInputNotification(on viewController: UIViewController) {
        
        print("its in ShowName...")
        let alertController = UIAlertController(title: "Trip Name", message: "Please enter your trip name:", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            textField.placeholder = "trip Name"
        }

        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if let nameTextField = alertController.textFields?.first, let name = nameTextField.text {
                Notifications.tripName = name
                self.showYesNoNotificationForContact(on: viewController)
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
    
    // entekhab mabda ba maghsad
    

    func showYesNoNotificationForTrip(on viewController: UIViewController) {
        let alertController = UIAlertController(title: "Notification", message: "Are you sure you want to add this Trip?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            // Handle "Yes" button action
            self.showYesNoNotificationForContact(on : viewController )
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
    func showYesNoNotificationForContact(on viewController: UIViewController) {
        let alertController = UIAlertController(title: "Notification", message: "Do you  want to add fellow traveler?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            let storyboard = UIStoryboard(name: "TravelList", bundle: nil)
            let myViewController = storyboard.instantiateViewController(withIdentifier: "TableViewForSelect") as! TableViewForSelect
            viewController.present(myViewController, animated: true, completion: nil)
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
}
