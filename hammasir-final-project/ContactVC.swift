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

class ContactVC : UIViewController {
    
    @IBOutlet weak var contactTableTV: UITableView!
    
    var contactsModel = ContactsManager(contactStorage: UserDefaultsDB())

    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupTableView()
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            contactsModel.deleteContact(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ShowContactDetailSegue", sender: indexPath)
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

