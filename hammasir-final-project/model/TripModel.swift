
import Foundation

class tripModel {
    
    var tripStorage : TravelStorage
    
    init(tripStorage: TravelStorage) {
        
        self.tripStorage = tripStorage
    }
    
    func gettripsHistory() -> [TravalInformation]{
        
        return self.tripStorage.fetchTravels()
    }
    
    func getTripsName() -> [String]{
        
        return self.tripStorage.fetchTravels().map { $0.getTripName() }
    }
    
    func getFellowTravelers() -> [[ContactInformation]]{
        
        return self.tripStorage.fetchTravels().map { $0.getFellowTraveler() }
    }
    
    func getOriginTrip() -> [Double]{
        
        return self.tripStorage.fetchTravels().map{ $0.getOrigin()}
    }
    
    func getDestination() -> [Double]{
        
        return self.tripStorage.fetchTravels().map{ $0.getDestination()}
    }
    
    func addNewTrip( newName : String, newFellowTravelers : [ContactInformation], newOrigin : Double, newDestination : Double ){
        
        let newTrip : TravalInformation = TravalInformation(origin: newOrigin,
                                                            destination: newDestination,
                                                            fellowTraveler: newFellowTravelers,
                                                            tripName: newName)
        self.tripStorage.saveTravel(newTrip)
    }
    
}
