import Foundation

class StartingTripFlowController{
    
    static var tripName : String?
    
    func showNameInputNotification(on viewController: UIViewController) {
        
        let alertController = UIAlertController(title: "Trip Name",
                                                message: "Please enter your trip name:",
                                                preferredStyle: .alert)

        alertController.addTextField {(textField) in
            
            textField.placeholder = "trip Name"
        }

        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if let nameTextField = alertController.textFields?.first, let name = nameTextField.text {
                StartingTripFlowController.tripName = name
                self.showYesNoNotificationForContact(on: viewController)
                print("User's trip name is \(name)")
            }
        }

        let noAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }

        alertController.addAction(okAction)
        alertController.addAction(noAction)

        viewController.present(alertController, animated: true, completion: nil)
    }
    
    // entekhab mabda ba maghsad
    

    func showYesNoNotificationForTrip(on viewController: UIViewController) {
        
        let alertController = UIAlertController(title: "Notification",
                                                message: "Are you sure you want to add this Trip?",
                                                preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            
            self.showYesNoNotificationForContact(on : viewController )
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func showYesNoNotificationForContact(on viewController: UIViewController) {
        
        let alertController = UIAlertController(title: "Notification",
                                                message: "Do you  want to add fellow traveler?",
                                                preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            
            guard let bundle = Bundle(identifier: "neshan.neshanMap") else {
                
                print("bundel did not resived")
                return
            }
            let storyboard = UIStoryboard(name: "TravelList", bundle: bundle)
            let myViewController = storyboard.instantiateViewController(withIdentifier: "TableViewForSelect") as! TableViewForSelectController
            viewController.present(myViewController, animated: true, completion: nil)
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
