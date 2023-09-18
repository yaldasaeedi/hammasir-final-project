//
//  AddContactVC.swift
//  hammasir-final-project
//
//  Created by Helen Besharatian on 6/22/1402 AP.
//
//
//  ViewControllerForAddContact.swift
//  Contact List
//
//  Created by Helen Besharatian on 6/7/1402 AP.
//

import UIKit

enum ContactViewMode {
    case viewAddEdit
    case add
}

class AddContactVC: UIViewController {

    
    @IBOutlet weak var contactImageIV: UIImageView!
    @IBOutlet weak var contactNameTF: UITextField!
    @IBOutlet weak var contactNumderTF: UITextField!
    @IBOutlet weak var contactEmailTF: UITextField!
    @IBOutlet weak var contactBirthdayDP: UIDatePicker!
    @IBOutlet weak var contactNoteTF: UITextField!
    
    var contactsModel = ContactsManager(contactStorage: ContactUserDefaultsDB(storageKey: "contacts"))
    var contactForEdit : ContactInformation?
    var editingContactIndexPath : IndexPath?
    var contactViewMode: ContactViewMode = .add

    private var newName : String?
    private var newNumber : Int64?
    private var newEmail : String?
    private var newImage : UIImage?
    private var newBirthday: Date?
    private var newNote : String?
    private var newIsChecked : Bool?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if contactViewMode == .viewAddEdit{
            
            isEditing()
        }else{
            
            setDefaultImageAndDate()
        }
    }
    
    @IBAction func addingContactPhoto(_ sender: Any) {
        
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func addingContactName(_ sender: Any) {
        
        guard let unwrappedName = contactNameTF.text else{
            
            print("nill name")
            return
        }
        newName = unwrappedName
    }
    
    @IBAction func addingContactNumber(_ sender: Any) {
        
        guard let unwrappedNumber = Int64(contactNumderTF.text!) else{
            
            print("nill number")
            return
        }
        newNumber = unwrappedNumber
    }
    
    @IBAction func addingContactEmail(_ sender: Any) {
        
        guard let unwrappedEmail = contactEmailTF.text else{
            
            print("nill email")
            return
        }
        newEmail = unwrappedEmail
    }
    
    @IBAction func addingContactBirthdat(_ sender: UIDatePicker){

        newBirthday = sender.date
    }
    
    @IBAction func addingContactNote(_ sender: Any) {
        
        guard let unwrappedNote = contactNoteTF.text else{
            
            print("nill Note")
            return
        }
        newNote = unwrappedNote
    }
    
    @IBAction func contactInfoAdded(_ sender: Any) {
        
        if contactViewMode == .viewAddEdit{

            let editingContact = ContactInformation(name:  newName!,
                                                    number: newNumber!,
                                                    email: newEmail!,
                                                    image: (newImage?.jpegData(compressionQuality: 0.8))!,
                                                    birthday: newBirthday!,
                                                    note: newNote!,
                                                    isChecked: newIsChecked ?? false)
            contactsModel.editContact(editedContact: editingContact, indexPath: editingContactIndexPath!)
            navigationController?.popViewController(animated: true)

        }else{

            contactsModel.addContact(newName: newName ?? "no name",
                                     newNumber: newNumber ?? 0 ,
                                     newEmail: newEmail ?? "no email",
                                     newImage: (newImage?.jpegData(compressionQuality: 0.8))!,
                                     newBirthday: newBirthday!,
                                     newNote: newNote ?? "no note",
                                     newIsChecked: false)
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func setDefaultImageAndDate(){
        
        contactImageIV.image = UIImage(named: "Image")
        newImage = contactImageIV.image!
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = 1990
        dateComponents.month = 1
        dateComponents.day = 1
        newBirthday = calendar.date(from: dateComponents)
        
        contactBirthdayDP.date = newBirthday ?? Date()
    }
    
    private func isEditing(){
        
        contactImageIV.image = UIImage(data : (contactForEdit?.getContactImage())!)
        contactNameTF.text = contactForEdit?.getContactName()
        contactNumderTF.text = contactForEdit?.getContactPhone().description
        contactEmailTF.text = contactForEdit?.getContactEmail()
        contactBirthdayDP.date = (contactForEdit?.getContactBirthday())!
        contactNoteTF.text = contactForEdit?.getContactNote()

        newImage = UIImage(data : (contactForEdit?.getContactImage())!)
        newName = contactForEdit?.getContactName()
        newNumber = contactForEdit?.getContactPhone()
        newEmail = contactForEdit?.getContactEmail()
        newBirthday = (contactForEdit?.getContactBirthday())!
        newNote = contactForEdit?.getContactNote()

    }
}
    
extension AddContactVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
            if let pickedImage = info[.originalImage] as? UIImage {
                
                contactImageIV.image = pickedImage
                newImage = pickedImage
                
            }else{
                
                print("image is nill")
            }

        dismiss(animated: true, completion: nil)
    }
}
protocol ContactScreenDelegate: AnyObject {
    
    var contactViewMode: ContactViewMode { get set }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

