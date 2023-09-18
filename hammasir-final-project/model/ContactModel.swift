
import UIKit

protocol ContactReader {
    
    func getContactsArray() -> [ContactInformation]
    func getContactsPhone() -> [Int64]
    func getContactsName() -> [String]
    func getIsChecked() -> [Bool]
    func getContactStorage() -> ContactStorage
}

protocol ContactWriter {
    
    func addContact(newName: String, newNumber: Int64, newEmail: String, newImage: Data, newBirthday: Date, newNote: String, newIsChecked: Bool)
    func deleteContact(indexPath: IndexPath)
    func editContact(editedContact: ContactInformation, indexPath: IndexPath)
    func updateContactIsChecked(isChecked: Bool, at indexPath: IndexPath)
}

class ContactsManager: ContactReader, ContactWriter {
    
    private let contactStorage: ContactStorage
    
    init(contactStorage: ContactStorage) {
        
        self.contactStorage = contactStorage
    }
    
    func getContactsArray() -> [ContactInformation] {
        
        return self.contactStorage.fetchContacts()
    }
    
    func getContactsPhone() -> [Int64] {
        
        return self.getContactsArray().map { $0.getContactPhone() }
    }
    
    func getContactsName() -> [String] {
        
        return self.getContactsArray().map { $0.getContactName() }
    }
    
    func getIsChecked() -> [Bool]{
        
        return self.getContactsArray().map { $0.getIsChecked() }
    }
    
    func getContactStorage() -> ContactStorage {
        return self.contactStorage
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
        
        self.contactStorage.deleteContact(at: indexPath)
    }
    
    func editContact(editedContact: ContactInformation, indexPath: IndexPath) {
        
        self.contactStorage.editContact(editedContact, at: indexPath)
    }
    
    func updateContactIsChecked(isChecked: Bool, at indexPath: IndexPath) {
        
        self.contactStorage.updateContactIsChecked(isChecked, at: indexPath)
    }
}
