
import Foundation

class tripModel {
    
    private var tripStorage : TravelStorage
    
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
    
    func getOriginTripLat() -> [Double]{
        
        return self.tripStorage.fetchTravels().map{ $0.getOriginLat()}
    }
    
    func getOriginTripLng() -> [Double]{
        
        return self.tripStorage.fetchTravels().map{ $0.getOriginLng()}
    }
    
    func getDestinationLat() -> [Double]{
        
        return self.tripStorage.fetchTravels().map{ $0.getDestinationLat()}
    }
    
    func getDestinationLng() -> [Double]{
        
        return self.tripStorage.fetchTravels().map{ $0.getDestinationLng()}
    }
    
    func getTripStorage() -> TravelStorage{
        
        return self.tripStorage
    }
    
    func addNewTrip(newOriginLat: Double, newOriginLng: Double, newDestinationLat: Double, newDestinationLng: Double, newFellowTraveler: [ContactInformation], newTripName: String, newOriginFormattedAddress: String, newDestinationFormattedAddress: String){
        
        let newTrip : TravalInformation = TravalInformation(originLat: newOriginLat,
                                                            originLng: newOriginLng,
                                                            destinationLat: newDestinationLat,
                                                            destinationLng: newDestinationLng,
                                                            fellowTraveler: newFellowTraveler,
                                                            tripName: newTripName,
                                                            originFormattedAddress: newOriginFormattedAddress,
                                                            destinationFormattedAddress: newDestinationFormattedAddress)
        self.tripStorage.saveTravel(newTrip)
    }
    
}
