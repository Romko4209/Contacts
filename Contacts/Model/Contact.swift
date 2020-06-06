//
//  Contact.swift
//  Contacts
//
//  Created by Romko on 06.06.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import Foundation
import UIKit

struct Contact {
    private var name: String
    private var surname: String
    private var email: String
    private let imagePerson: UIImage?
    
    func getName() -> String{
        return name
    }
    func getSurname() -> String{
           return surname
       }
    func getEmail() -> String{
           return email
       }
    func getImagePerson() -> UIImage{
    
        if let image = imagePerson {
            return image
        }
        return UIImage.init(contentsOfFile: "photo.fill")!
       }
}
