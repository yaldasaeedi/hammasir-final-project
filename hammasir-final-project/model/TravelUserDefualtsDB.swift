
import Foundation

protocol TravelStorage {
    
    func saveTravel(_ travel: TravalInformation)
    func fetchTravels() -> [TravalInformation]
    func deleteTravel(at indexPath: IndexPath)
    }

class TravelUserDefualtsDB : TravelStorage{
    
    private let userDefaults = UserDefaults.standard
    private var storageKey: String
    
    init(storageKey: String) {
        
        self.storageKey = storageKey
    }
    
    func saveTravel(_ travel: TravalInformation) {
        do {
            
            let encoder = JSONEncoder()
            
            var savedTravels = fetchTravels()
            savedTravels.append(travel)
    
            let encodedData = try encoder.encode(savedTravels)
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
    func deleteTravel(at indexPath: IndexPath) {
        
        var savedContacts = fetchTravels()
        savedContacts.remove(at: indexPath.row)
        
        do {
            
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(savedContacts)
            userDefaults.set(encodedData, forKey: storageKey)
        } catch {
            
            print("Error occurred while encoding data: \(error)")
        }
    }
}
