//
//  ContactVC.swift
//  hammasir-final-project
//
//  Created by Helen Besharatian on 6/22/1402 AP.
//
//
//  ViewController.swift
//  Contact List
//
//  Created by Helen Besharatian on 6/6/1402 AP.


import UIKit
import Foundation
class ContactVC : UIViewController {
    
    @IBOutlet weak var contactTableTV: UITableView!
    var selectedIndexPath: IndexPath?
    var trip = tripTable(tripModel: TravelUserDefualtsDB(storageKey: "trips"))
    var contactsModel = ContactsManager(contactStorage: ContactUserDefaultsDB(storageKey: "contacts"))
    static var fellowTravelerName : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSwipeGestureRecognizer()
        contactTableTV.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        contactTableTV.reloadData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        contactsModel.contactStorage.fetchContacts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowContactDetailSegue",
           let indexPath = sender as? IndexPath {
            
            prepareContactDetailSegue(for: segue, indexPath: indexPath)
        }
    }
    
    
    private func setupTableView() {
        
            contactTableTV.delegate = self
            contactTableTV.dataSource = self
            contactTableTV.register(CustomTableViewCell.self, forCellReuseIdentifier: "contactCell")
    }
        
    private func prepareContactDetailSegue(for segue: UIStoryboardSegue, indexPath: IndexPath) {
        
        let selectedContact = contactsModel.getContactsArray()[indexPath.row]
        
        if let destinationVC = segue.destination as? AddContactVC {
            
            destinationVC.contactViewMode = .viewAddEdit
            destinationVC.contactForEdit = selectedContact
            destinationVC.editingContactIndexPath = indexPath
        }
    }
    @IBAction func doneClicked(_ sender: Any) {
        for checkedContact in contactsModel.getContactsArray(){
            if checkedContact.getIsChecked() == true {
                
                ContactVC.fellowTravelerName?.append(checkedContact.getContactName())
            }
        }
        
    }
    
}


extension ContactVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactsModel.getContactsArray().count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! CustomTableViewCell
        let contact = contactsModel.getContactsArray()[indexPath.row]
        cell.textLabel?.text = contact.getContactName()
        if let imageView = cell.imageView {
            let originalImage = UIImage(data : contact.getContactImage())
            let newSize = CGSize(width: 16.0, height: 16.0)
            let resizedImage = originalImage?.resizedImage(withSize: newSize)
            imageView.image = resizedImage
            
        }
        if contact.getIsChecked() == true {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//
//            contactsModel.deleteContact(indexPath: indexPath)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                contactsModel.deleteContact(indexPath: indexPath)
                tableView.deleteRows(at: [indexPath], with: .fade)

                contactTableTV.reloadData()
            }
        }
    
    private func setupSwipeGestureRecognizer() {
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight(_:)))
        swipeRightGesture.direction = .right
        contactTableTV.addGestureRecognizer(swipeRightGesture)
    }

    @objc private func handleSwipeRight(_ gesture: UISwipeGestureRecognizer) {
        guard let selectedIndexPath = selectedIndexPath else {
            return
        }
        performSegue(withIdentifier: "ShowContactDetailSegue", sender: selectedIndexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        selectedIndexPath = indexPath
        
        var contact = contactsModel.getContactsArray()[indexPath.row]
        if contact.getIsChecked() == true {
            cell?.accessoryType = .none
            contactsModel.updateContactIsChecked(isChecked: false, at: indexPath)
            
        } else {
            cell?.accessoryType = .checkmark
            contactsModel.updateContactIsChecked(isChecked: true, at: indexPath)
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UIImage {
    
    func resizedImage(withSize newSize: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }

        self.draw(in: CGRect(origin: .zero, size: newSize))

        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }

        return UIImage(cgImage: resizedImage)
    }
    
}
