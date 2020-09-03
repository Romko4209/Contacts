//
//  Contact.swift
//  Contacts
//
//  Created by Romko on 06.06.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import RealmSwift
import UIKit

class Contact: Object{
    
    @objc private dynamic var name = ""
    @objc private dynamic var surname = ""
    @objc private dynamic var email = ""
    @objc private dynamic var imagePerson = UIImage.init(contentsOfFile: "photo.fill")!.pngData()
    
    init(name:String,surname: String,email: String,imagePerson: UIImage) {
        self.name = name
        self.surname = surname
        self.email = email
        self.imagePerson = imagePerson.pngData()
    }
    
    required init() {
        fatalError("init() has not been implemented")
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
