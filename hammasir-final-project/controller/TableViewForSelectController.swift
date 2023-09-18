import UIKit

class TableViewForSelectController: UITableViewController {
    
    @IBOutlet var contactTableCell: UITableView!
    
    var selectedIndexPath: IndexPath?
    var contactsModel = ContactsManager(contactStorage: ContactUserDefaultsDB(storageKey: "contacts"))
    
    static var fellowTravelerName : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactTableCell.register(CustomTableViewCell.self, forCellReuseIdentifier: "contactSelectionCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactsModel.getContactsArray().count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactSelectionCell", for: indexPath) as! CustomTableViewCell
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        selectedIndexPath = indexPath

        let contact = contactsModel.getContactsArray()[indexPath.row]
        
        if contact.getIsChecked() == true {
            
            cell?.accessoryType = .none
            contactsModel.updateContactIsChecked(isChecked: false, at: indexPath)
        } else {
            
            cell?.accessoryType = .checkmark
            contactsModel.updateContactIsChecked(isChecked: true, at: indexPath)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func DoneClicked(_ sender: Any) {
        
        for checkedContact in contactsModel.getContactsArray(){
            
            if checkedContact.getIsChecked() == true {
                
                TableViewForSelectController.fellowTravelerName?.append(checkedContact.getContactName())
                dismiss(animated: true, completion: nil)
                
            }
        }
    }
}
