//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Romko on 07.06.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {

    
     var delegate: ContactVCDelegate?
    
    
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneButton(_ sender: Any) {
       
        let image = #imageLiteral(resourceName: "wp6280052-desktop-lv-wallpapers")
        let contact = Contact(name: "1",
                              surname: "2",
                              email: "3",
                              imagePerson: image)
        
        delegate?.updateContacts(contact)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    

}
