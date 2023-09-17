//
//  FellowTravelers.swift
//  hammasir-final-project
//
//  Created by Helen Besharatian on 6/26/1402 AP.
//

import Foundation

class FellowTravelers : ContactsManager {
    
    func setTraveler(traveler : ContactInformation){
        
        self.contactStorage.saveContact(traveler)
    }
    func getTravelersArray() -> [ContactInformation] {
       
        return self.getContactsArray()
    }
    
    
    
    
    
}
