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
    
    // entekhab mabda ba maghsad
    
//    func getDataFromMapController(newOriginLng: Double,
//                                             newOriginLat: Double,
//                                             newDestinationLng: Double,
//                                             newDestinationLat: Double,
//                                             newFormattedAddress: String,
//                                             newViewController: UIViewController) {
//            TripData.shared.originLng = newOriginLng
//            TripData.shared.originLat = newOriginLat
//            TripData.shared.destinationLng = newDestinationLng
//            TripData.shared.destinationLat = newDestinationLat
//            TripData.shared.formattedAddress = newFormattedAddress
//        tripIsAdding()
//        }
//    func showYesNoNotificationForTrip(on viewController: UIViewController) {
//
//        let alertController = UIAlertController(title: "Notification",
//                                                message: "Are you sure you want to add this Trip?",
//                                                preferredStyle: .alert)
//
//        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
//
//            self.showYesNoNotificationForContact(on : viewController )
//        }
//
//        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in
//        }
//
//        alertController.addAction(yesAction)
//        alertController.addAction(noAction)
//
//        viewController.present(alertController, animated: true, completion: nil)
//    }
    
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
            
            let storyboard = UIStoryboard(name: "TravelList", bundle: bundle)
            let myViewController = storyboard.instantiateViewController(withIdentifier: "TripHistory") as! TravelHistoryTableController
            
            viewController.present(myViewController, animated: true, completion: nil)
            
            self.tripIsAdding()
            
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in
        
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func tripIsAdding() {
        print(TripData.shared.originFormattedAddress)
        print(TripData.shared.destinationFormattedAddress)
        self.tripsModel.addNewTrip(newOriginLat: TripData.shared.originLat,
                                   newOriginLng: TripData.shared.originLng,
                                   newDestinationLat: TripData.shared.destinationLat,
                                   newDestinationLng: TripData.shared.destinationLng,
                                   newFellowTraveler: TripData.shared.fellowTravelers,
                                   newTripName: TripData.shared.tripName,
                                   newOriginFormattedAddress: TripData.shared.originFormattedAddress,
                                   newDestinationFormattedAddress: TripData.shared.destinationFormattedAddress
                            
            )
        

    }
}
