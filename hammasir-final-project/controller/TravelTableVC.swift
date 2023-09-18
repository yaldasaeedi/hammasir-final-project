//
//  TravelTableVC.swift
//  hammasir-final-project
//
//  Created by Helen Besharatian on 6/22/1402 AP.
//

import UIKit

class TravelTableVC: UIViewController{
    
    var tripsModel = tripTable(tripModel: TravelUserDefualtsDB(storageKey: "trips"))

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
}
extension TravelTableVC :  UITableViewDataSource, UITableViewDelegate{
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tripsModel.getTripsName().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelerCell", for: indexPath) as! CustomTableViewCell
        let tripName = tripsModel.getTripsName()[indexPath.row]
        cell.textLabel?.text = tripName
        
        return cell
    }
    
}
