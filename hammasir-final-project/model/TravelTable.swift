//
//  TravelTableM.swift
//  hammasir-final-project
//
//  Created by Helen Besharatian on 6/22/1402 AP.
//

import Foundation

class tripTable {
    
    var tripStorage : TravelStorage
    
    init(tripModel: TravelStorage) {
        
        self.tripStorage = tripModel
    }
    func gettripsHistory() -> [TravalInformation]{
        
       return tripStorage.fetchTravels()
    }
    func getTripsName() -> [String]{
        
        return tripStorage.fetchTravels().map { $0.getTripName() }
    }
    func getFellowTravelers() -> [[ContactInformation]]{
        
        return tripStorage.fetchTravels().map { $0.getFellowTraveler() }
    }
    func getOriginTrip() -> [Double]{
        
        return tripStorage.fetchTravels().map{ $0.getOrigin()}
    }
    func getDestination() -> [Double]{
        
        return tripStorage.fetchTravels().map{ $0.getDestination()}
    }
    func addNewTrip( newName : String, newFellowTravelers : [ContactInformation], newOrigin : Double, newDestination : Double ){
        
        let newTrip : TravalInformation = TravalInformation(origin: newOrigin,
                                                            destination: newDestination,
                                                            fellowTraveler: newFellowTravelers,
                                                            tripName: newName)
        tripStorage.saveTravel(newTrip)
    }
}
