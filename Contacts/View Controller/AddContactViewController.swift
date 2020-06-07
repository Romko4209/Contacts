//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Romko on 07.06.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imagePerson: UIImageView!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var buttonDone: UIBarButtonItem!
    @IBOutlet var buttonAddPhoto: UIButton!
    
    
    
    var delegate: ContactVCDelegate?
    var contact: Contact?
    var segueIdentifier:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
      
        if let contact = contact {
            
            firstNameTextField.text = contact.getName()
            lastNameTextField.text = contact.getSurname()
            emailTextField.text = contact.getEmail()
            imagePerson.image = contact.getImagePerson()
            
        }
        if let segueIdentifier = segueIdentifier {
            if segueIdentifier == "tapToCell"{
            buttonAddPhoto.isHidden = true
            }
        }
        
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneButton(_ sender: Any) {
       
        guard let image = imagePerson.image else {return}
        guard let firstName = firstNameTextField.text else {return}
        guard let lastName = lastNameTextField.text else {return}
        guard let email = emailTextField.text else {return}
        let contact = Contact(name: firstName,
                              surname: lastName,
                              email: email,
                              imagePerson: image)
        
        guard let segueIdentifier = segueIdentifier else {
            return
        }
        delegate?.updateContacts(contact,identifier: segueIdentifier)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func addPhotoButton(_ sender: Any) {
        let picker = UIImagePickerController()
         picker.allowsEditing = true
         picker.delegate = self
         let ac = UIAlertController(title: "Choose!", message: nil, preferredStyle: .actionSheet)
         
        ac.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
             if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
             {
                 picker.sourceType = .camera

             }
             else
             {
                 let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                 self?.present(alert, animated: true, completion: nil)
             }
             self?.present(picker,animated: true)
             
         }))
        
         ac.addAction(UIAlertAction(title: "Library", style: .default, handler: { [weak self] _ in
             self?.present(picker,animated: true)
         }))
         ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
         
         present(ac,animated: true)
        
         
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }

        
        let path = getDocumentsDirectory().appendingPathComponent(imageName)
        imagePerson.image = UIImage(contentsOfFile: path.path)
        
        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    
    @IBAction func didChangeTextField(_ sender: UITextField) {
        if firstNameTextField.text != "" || lastNameTextField.text != "" || emailTextField.text != "" {
            buttonDone.isEnabled = true
        }else{
            buttonDone.isEnabled = false
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
extension AddContactViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}
