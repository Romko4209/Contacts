//
//  ContactsViewController.swift
//  Contacts
//
//  Created by Romko on 06.06.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var contacts = [Contact]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        
    }
    

}

