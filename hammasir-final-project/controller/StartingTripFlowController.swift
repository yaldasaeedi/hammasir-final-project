import Foundation

class TripData {
    
    static let shared = TripData()
    
    var tripName : String = ""
    var originLng: Double = 0.0
    var originLat: Double = 0.0
    var destinationLng: Double = 0.0
    var destinationLat: Double = 0.0
    var fellowTravelers : [ContactInformation] = []
    var originFormattedAddress: String = ""
    var destinationFormattedAddress: String = ""
    
    private init() {}
}

class StartingTripFlowController{
    
    var tripsModel = tripModel(tripStorage: TravelUserDefualtsDB(storageKey: "trips"))

    
    func showNameInputNotification(on viewController: UIViewController) {
        
        let alertController = UIAlertController(title: "Trip Name",
                                                message: "Please enter your trip name:",
                                                preferredStyle: .alert)

        alertController.addTextField {(textField) in
            
            textField.placeholder = "trip Name"
        }

        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if let nameTextField = alertController.textFields?.first, let name = nameTextField.text {
                TripData.shared.tripName = name
                // entekhab mabda ba maghsad
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
    
    func showYesNoNotificationForSavingTrip(on viewController: UIViewController) {
        
        let alertController = UIAlertController(title: "Notification",
                                                message: "Do you  want to save your trip?",
                                                preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            
            guard let bundle = Bundle(identifier: "neshan.neshanMap") else {
                
                print("bundel did not resived")
                return
            }
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

            // Create an instance of the root view controller from the main storyboard
            guard let rootViewController = mainStoryboard.instantiateInitialViewController() else {
                fatalError("Unable to instantiate root view controller from main storyboard")
            }

            // Set the presentation style and transition style
            rootViewController.modalPresentationStyle = .fullScreen
            rootViewController.modalTransitionStyle = .coverVertical

            // Dismiss or pop all the presented view controllers until you reach the root view controller
            if let presentingViewController = viewController.presentingViewController {
                presentingViewController.dismiss(animated: true) {
                    // Present the root view controller
                    presentingViewController.present(rootViewController, animated: true, completion: nil)
                }
            }
            self.tripIsAdding()
            
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in
        
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func tripIsAdding() {
        
        self.tripsModel.addNewTrip(newOriginLat: TripData.shared.originLat,
                                   newOriginLng: TripData.shared.originLng,
                                   newDestinationLat: TripData.shared.destinationLat,
                                   newDestinationLng: TripData.shared.destinationLng,
                                   newFellowTraveler: TripData.shared.fellowTravelers,
                                   newTripName: TripData.shared.tripName,
                                   newOriginFormattedAddress: TripData.shared.originFormattedAddress,
                                   newDestinationFormattedAddress: TripData.shared.destinationFormattedAddress
                            
            )
        print(TripData.shared.destinationFormattedAddress)
        

    }
}
