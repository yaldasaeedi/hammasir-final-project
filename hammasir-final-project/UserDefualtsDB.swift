//
//  UserDefualtsDB.swift
//  hammasir-final-project
//
//  Created by Helen Besharatian on 6/22/1402 AP.
//
import Foundation

protocol ContactStorage {
    
    func saveContact(_ contact: ContactInformation)
    func fetchContacts() -> [ContactInformation]
    func deleteContact(at indexPath: IndexPath)
    func editContact(_ updatedContact: ContactInformation, at indexPath: IndexPath)
    func updateContactIsChecked(_ isChecked: Bool, at indexPath: IndexPath)
}
class UserDefaultsDB: ContactStorage {
    
    private let userDefaults = UserDefaults.standard
    private var storageKey: String
    
    init(storageKey: String) {
        self.storageKey = storageKey
    }
    func saveContact(_ contact: ContactInformation) {
        
        var savedContacts = fetchContacts()
        savedContacts.append(contact)
        
        do {
            
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(savedContacts)
            userDefaults.set(encodedData, forKey: storageKey)
        } catch {
            
            print("Error occurred while encoding data: \(error)")
        }
    }
    
    func fetchContacts() -> [ContactInformation] {
        
        guard let encodedData = userDefaults.data(forKey: storageKey) else {
            return []
        }
        
        do {
            
            let decoder = JSONDecoder()
            let savedContacts = try decoder.decode([ContactInformation].self, from: encodedData)
            return savedContacts
        } catch {
            
            print("Error occurred while decoding data: \(error)")
            return []
        }
    }
    
    func theLastSave(){
        
        var savedContacts = fetchContacts()
        do {
            
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(savedContacts)
            userDefaults.set(encodedData, forKey: storageKey)
        } catch {
            
            print("Error occurred while encoding data: \(error)")
        }
    }
    
    func deleteContact(at indexPath: IndexPath) {
        var savedContacts = fetchContacts()
        savedContacts.remove(at: indexPath.row)
        
        do {
            
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(savedContacts)
            userDefaults.set(encodedData, forKey: storageKey)
        } catch {
            
            print("Error occurred while encoding data: \(error)")
        }
    }
    
    func editContact(_ updatedContact: ContactInformation, at indexPath: IndexPath) {
        
        var savedContacts = fetchContacts()
        savedContacts[indexPath.row] = updatedContact
        
        do {
            
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(savedContacts)
            userDefaults.set(encodedData, forKey: storageKey)
        } catch {
            
            print("Error occurred while encoding data: \(error)")
        }
    }
    func updateContactIsChecked(_ isChecked: Bool, at indexPath: IndexPath){
        
        var savedContacts = fetchContacts()
        savedContacts[indexPath.row].isChecked = isChecked
        
        do {
            
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(savedContacts)
            userDefaults.set(encodedData, forKey: storageKey)
        } catch {
            
            print("Error occurred while encoding data: \(error)")
        }
    }
}
