
struct TravalInformation : Codable{
    
    private var originLat : Double
    private var originLng : Double
    private var destinationLat : Double
    private var destinationLng : Double
    private var fellowTraveler : [ContactInformation]
    private var tripName : String
    private var originFormattedAddress : String
    private var destinationFormattedAddress : String
    
    
    init(originLat: Double, originLng: Double, destinationLat: Double, destinationLng: Double, fellowTraveler: [ContactInformation], tripName: String, originFormattedAddress : String, destinationFormattedAddress : String) {
        
        self.originLat = originLat
        self.originLng = originLng
        self.destinationLat = destinationLat
        self.destinationLng = destinationLng
        self.fellowTraveler = fellowTraveler
        self.tripName = tripName
        self.originFormattedAddress = originFormattedAddress
        self.destinationFormattedAddress = destinationFormattedAddress
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
    
    func getOriginFormattedAddress() -> String{
        
        return self.originFormattedAddress
    }
    func getDestinationFormattedAddress() -> String{
        
        return self.destinationFormattedAddress
    }

    
}
