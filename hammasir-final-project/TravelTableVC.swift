//
//  TravelTableVC.swift
//  hammasir-final-project
//
//  Created by Helen Besharatian on 6/22/1402 AP.
//

import UIKit

class TravelTableVC: UIViewController{
    
    var travelersList = TravelModel(contactStorage: UserDefaultsDB(storageKey: "travelers"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
}
extension TravelTableVC :  UITableViewDataSource, UITableViewDelegate{
    
   
    
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return travelersList.getTravelersArray().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelerCell", for: indexPath) as! CustomTableViewCell
        let traveler = travelersList.getTravelersArray()[indexPath.row]
        cell.textLabel?.text = traveler.getContactName()
        if let imageView = cell.imageView {
            let originalImage = UIImage(data : traveler.getContactImage())
            let newSize = CGSize(width: 16.0, height: 16.0)
            let resizedImage = originalImage?.resizedImage(withSize: newSize)
            imageView.image = resizedImage

        }

        return cell
    }
}

