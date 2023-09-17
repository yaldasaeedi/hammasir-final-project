//
//  ContactM.swift
//  hammasir-final-project
//
//  Created by Helen Besharatian on 6/22/1402 AP.
//
import UIKit



protocol ContactReader {
    
    func getContactsArray() -> [ContactInformation]
    func getContactsPhone() -> [Int64]
    func getContactsName() -> [String]
}

protocol ContactWriter {
    
    func addContact(newName: String, newNumber: Int64, newEmail: String, newImage: Data, newBirthday: Date, newNote: String, newIsChecked: Bool)
    func deleteContact(indexPath: IndexPath)
    func editContact(editedContact: ContactInformation, indexPath: IndexPath)
    func updateContactIsChecked(isChecked: Bool, at indexPath: IndexPath)
}

class ContactsManager: ContactReader, ContactWriter {
    
    let contactStorage: ContactStorage
    
    init(contactStorage: ContactStorage) {
        
        self.contactStorage = contactStorage
    }
    
    func getContactsArray() -> [ContactInformation] {
        
        return contactStorage.fetchContacts()
    }
    
    func getContactsPhone() -> [Int64] {
        
        return getContactsArray().map { $0.getContactPhone() }
    }
    
    func getContactsName() -> [String] {
        
        return getContactsArray().map { $0.getContactName() }
    }
    
    func addContact(newName: String, newNumber: Int64, newEmail: String, newImage: Data, newBirthday: Date, newNote: String, newIsChecked: Bool) {
        
        let newContact = ContactInformation(name: newName,
                                            number: newNumber,
                                            email: newEmail,
                                            image: newImage,
                                            birthday: newBirthday,
                                            note: newNote,
                                            isChecked : newIsChecked)
        contactStorage.saveContact(newContact)
    }
    
    func deleteContact(indexPath: IndexPath) {
        
        contactStorage.deleteContact(at: indexPath)
    }
    
    func editContact(editedContact: ContactInformation, indexPath: IndexPath) {
        
        contactStorage.editContact(editedContact, at: indexPath)
    }
    func updateContactIsChecked(isChecked: Bool, at indexPath: IndexPath) {
        
        contactStorage.updateContactIsChecked(isChecked, at: indexPath)
    }
}
