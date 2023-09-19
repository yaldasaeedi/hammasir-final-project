
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
        print("in save travel")
        do {
            let encoder = JSONEncoder()
            var savedTravels = fetchTravels() // Fetch the existing travels
            
            savedTravels.append(travel) // Append the new travel
            
            let encodedData = try encoder.encode(savedTravels) // Encode the array of travels
            
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
            let savedTravels = try decoder.decode([TravalInformation].self, from: encodedData)
            return savedTravels
        } catch {
            print("Error occurred while decoding data: \(error)")
            return []
        }
    }
}
