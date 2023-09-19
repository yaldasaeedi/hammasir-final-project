
struct TravalInformation : Codable{
    
    private var originLat : Double
    private var originLng : Double
    private var destinationLat : Double
    private var destinationLng : Double
    private var fellowTraveler : [ContactInformation]
    private var tripName : String
    private var formattedAddress : String
    
    
    init(originLat: Double, originLng: Double, destinationLat: Double, destinationLng: Double, fellowTraveler: [ContactInformation], tripName: String, formattedAddress : String) {
        
        self.originLat = originLat
        self.originLng = originLng
        self.destinationLat = destinationLat
        self.destinationLng = destinationLng
        self.fellowTraveler = fellowTraveler
        self.tripName = tripName
        self.formattedAddress = formattedAddress
    }
    
    func getOriginLat() -> Double{
        
        return self.originLat
    }
    
    func getOriginLng() -> Double{
        
        return self.originLng
    }
    
    func getDestinationLat() -> Double{
        
        return self.destinationLat
    }
    
    func getDestinationLng() -> Double{
        
        return self.destinationLng
    }
    
    func getFellowTraveler() -> [ContactInformation]{
        
        return self.fellowTraveler
    }
    
    func getTripName() -> String{
        
        return self.tripName
    }
    
    func getFormattedAddress() -> String{
        
        return self.formattedAddress
    }
    
    
}
