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
    @objc private dynamic var imagePerson: Data? = nil
    


    
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

            if let imageData = imagePerson {
                return UIImage(data: imageData)!
            }
        return UIImage.init(contentsOfFile: "person.fill")!
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
   
    func setImage(_ image: UIImage){
        self.imagePerson = image.pngData()
    }
    
}
