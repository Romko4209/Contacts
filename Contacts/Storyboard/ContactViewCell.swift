//
//  ContactViewCell.swift
//  Contacts
//
//  Created by Romko on 06.06.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import UIKit

class ContactViewCell: UITableViewCell {

    @IBOutlet private var name: UILabel!
    @IBOutlet private var surname: UILabel!
    @IBOutlet private var email: UILabel!
    @IBOutlet private var imagePerson: UIImageView!
    
    func setupCell(_ person:Contact){
        name.text = person.getName()
        surname.text = person.getSurname()
        email.text = person.getEmail()
       // imagePerson.image = person.getImagePerson()
        
    }
    
}
