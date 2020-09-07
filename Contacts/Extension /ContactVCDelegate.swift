//
//  ContactVCDelegate.swift
//  Contacts
//
//  Created by Romko on 07.06.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import Foundation

protocol ContactVCDelegate {
    func updateContacts(_ contacts:Contact,identifier:String,pastContact:Contact)
}
