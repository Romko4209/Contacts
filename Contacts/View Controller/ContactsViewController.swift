
import UIKit
import RealmSwift

class ContactsViewController:UIViewController{
    
   
    @IBOutlet var tableView: UITableView!
    private var messageNoContacts: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No contacts!"
        label.textColor = .systemBlue
        return label
    }()
    
    private var contacts: Results<Contact>!
    private var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contacts = realm.objects(Contact.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        if contacts.count == 0{
            view.addSubview(messageNoContacts)
            messageNoContacts.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            messageNoContacts.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        guard let dest = segue.destination as? AddContactViewController else{return}
        if segue.identifier == "tapToCell"{
            dest.segueIdentifier = segue.identifier
            dest.contact = contact
            
        }else if segue.identifier == "ContactsToAddContact"{
            dest.segueIdentifier = segue.identifier
        }
        dest.delegate = self
    }
}

extension ContactsViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as! ContactViewCell
        let contact = contacts[indexPath.row]
        cell.setupCell(contact)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    
    contact = contacts[indexPath.row]
        
    tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "tapToCell", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {


        if editingStyle == .delete {

            StorageManager.deleteContact(contacts[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if contacts.count == 0{
                messageNoContacts.isHidden = false
            }
        }
    }
}

extension ContactsViewController: ContactVCDelegate{
 
    func updateContacts(_ contact: Contact, identifier: String,pastContact:Contact) {
        
        if identifier == "ContactsToAddContact"{
          
            StorageManager.saveContact(contact)
            
        }else if identifier == "tapToCell"{
            
            StorageManager.editContact(contact: pastContact,
                                       newName: contact.getName(),
                                       newSurname: contact.getSurname(),
                                       newEmail: contact.getEmail())
            
        }
               tableView.reloadData()
        messageNoContacts.isHidden = true
    }
}

