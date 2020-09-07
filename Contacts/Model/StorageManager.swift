//
//  StorageManager.swift
//  Contacts
//
//  Created by Romko on 04.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager{
   
        static func saveContact(_ contact: Contact) {
            try! realm.write {
                realm.add(contact)
               }
           }
    
    static func deleteContact(_ contact: Contact){
        try! realm.write{
            realm.delete(contact)
        }
    }
    
    static func editContact(contact: Contact, newName: String,
                            newSurname: String, newEmail: String){
        try! realm.write{
            contact.setName(newName)
            contact.setSurname(newSurname)
            contact.setEmail(newEmail)
        }
    }
    
}


