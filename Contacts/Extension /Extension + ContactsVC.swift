//
//  Extension + ContactsVC.swift
//  Contacts
//
//  Created by Romko on 06.06.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import  UIKit

extension ContactsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
}
