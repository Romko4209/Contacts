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
   
        static func saveContacts(_ Contacts: [Contact]) {
            try! realm.write {
                realm.add(Contacts)
               }
           }
}


