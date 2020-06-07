
import UIKit

class ContactsViewController:UIViewController{
    
   
    @IBOutlet var tableView: UITableView!
    
    
    private var contacts = [Contact]()
    private var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        let defaults = UserDefaults.standard

               if let savedPeople = defaults.object(forKey: "people") as? Data {
                   let jsonDecoder = JSONDecoder()

                   do {
                       contacts = try jsonDecoder.decode([Contact].self, from: savedPeople)
                   } catch {
                       print("Failed to load people")
                   }
               }
        
        
    }
    
    func save() {
           let jsonEncoder = JSONEncoder()
           if let savedData = try? jsonEncoder.encode(contacts) {
               let defaults = UserDefaults.standard
               defaults.set(savedData, forKey: "people")
           } else {
               print("Failed to save people.")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactViewCell
        let contact = contacts[indexPath.row]
        cell.setupCell(contact)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    
    contact = contacts[indexPath.row]
        
    tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "tapToCell", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        
        if editingStyle == .delete {

            contacts.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .fade)
            save()
        }
    }
    
    
    
    
}
extension ContactsViewController: ContactVCDelegate{
    func updateContacts(_ contact: Contact, identifier: String) {
        
        if identifier == "ContactsToAddContact"{
        self.contacts.append(contact)
        }else if identifier == "tapToCell"{
            
            for item in self.contacts{
                if item.getImagePerson() == contact.getImagePerson(){
                    item.setName(contact.getName())
                    item.setSurname(contact.getSurname())
                    item.setEmail(contact.getEmail())
                }
            }
            
        }
               tableView.reloadData()
        save()
            
    }
    
    
    
}

