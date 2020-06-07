//
//  Contact.swift
//  Contacts
//
//  Created by Romko on 06.06.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import Foundation
import UIKit

class Contact: Codable{
    
    private var name: String
    private var surname: String
    private var email: String
    private var imagePerson: Data?
    
    init(name:String,surname: String,email: String,imagePerson: UIImage) {
        self.name = name
        self.surname = surname
        self.email = email
        self.imagePerson = imagePerson.pngData()
    }
    
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
            return UIImage(data: image)!
        }
        return UIImage.init(contentsOfFile: "photo.fill")!
       }
    
    func setName(_ name:String){
        self.name = name
    }
    func setSurname(_ surname:String){
        self.surname = surname
    }
    func setEmail(_ email:String){
        self.email = email
    }
   
}
