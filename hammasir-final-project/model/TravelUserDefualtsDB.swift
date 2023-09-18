
import Foundation

protocol TravelStorage {
    
    func saveTravel(_ travel: TravalInformation)
    func fetchTravels() -> [TravalInformation]
    }

class TravelUserDefualtsDB : TravelStorage{
    
    private let userDefaults = UserDefaults.standard
    private var storageKey: String
    
    init(storageKey: String) {
        self.storageKey = storageKey
    }
    
    func saveTravel(_ travel: TravalInformation) {
        
        let savedTravel = fetchTravels()
        
        
        do {
            
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(savedTravel)
            userDefaults.set(encodedData, forKey: storageKey)
        } catch {
            
            print("Error occurred while encoding data: \(error)")
        }
    }
    
    func fetchTravels() -> [TravalInformation] {
        
        guard let encodedData = userDefaults.data(forKey: storageKey) else {
            
            return []
        }
        do {
            
            let decoder = JSONDecoder()
            let savedTravel = try decoder.decode([TravalInformation].self, from: encodedData)
            return savedTravel
        } catch {
            
            print("Error occurred while decoding data: \(error)")
            return []
        }
    }
    
}
