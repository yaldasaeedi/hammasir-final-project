
struct TravalInformation : Encodable, Decodable{
    
    private var origin : Double
    private var destination : Double
    private var fellowTraveler : [ContactInformation]
    private var tripName : String
    
    init(origin: Double, destination: Double, fellowTraveler: [ContactInformation], tripName: String) {
        
        self.origin = origin
        self.destination = destination
        self.fellowTraveler = fellowTraveler
        self.tripName = tripName
    }
    
    func getOrigin() -> Double{
        
        return self.origin
    }
    
    func getDestination() -> Double{
        
        return self.destination
    }
    
    func getFellowTraveler() -> [ContactInformation]{
        
        return self.fellowTraveler
    }
    
    func getTripName() -> String{
        
        return self.tripName
    }
    
    
}
