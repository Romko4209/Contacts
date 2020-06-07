
import UIKit

class ContactsViewController:UIViewController{
    
   
    @IBOutlet var tableView: UITableView!
    
    
    private var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? AddContactViewController {
            dest.delegate = self
            
        }
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
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
extension ContactsViewController: ContactVCDelegate{
    func updateContacts(_ contact: Contact) {
        self.contacts.append(contact)
        tableView.reloadData()
    }
    
}

