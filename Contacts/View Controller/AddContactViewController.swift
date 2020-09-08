//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Romko on 07.06.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet var imagePerson: UIImageView!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var buttonDone: UIBarButtonItem!
    @IBOutlet var buttonAddPhoto: UIButton!
    

    
    var currentImage: UIImage?
    var delegate: ContactVCDelegate?
    var contact: Contact?
    var segueIdentifier:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupKeyboard()
        
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
    
    func setupKeyboard(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddContactViewController.backgroundTap))
         self.view.addGestureRecognizer(tapGestureRecognizer)
         
        
         NotificationCenter.default.addObserver(self, selector: #selector(AddContactViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
         
         NotificationCenter.default.addObserver(self, selector: #selector(AddContactViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneButton(_ sender: Any) {
      
        guard let firstName = firstNameTextField.text else {return}
        guard let lastName = lastNameTextField.text else {return}
        guard let email = emailTextField.text else {return}
        var image = #imageLiteral(resourceName: "toppng.com-blue-person-icon-blue-person-icon-271x350")
        if let currentImage = self.currentImage {
            image = currentImage
        }
        
        let contact = Contact()
        contact.setName(firstName)
        contact.setSurname(lastName)
        contact.setEmail(email)
        contact.setImage(image)
        
        guard let segueIdentifier = segueIdentifier else {
            print("Error segueIdentifier method doneButton")
            return
        }
        
        if let pastContact = self.contact{
            delegate?.updateContacts(contact,identifier: segueIdentifier,pastContact:pastContact)
        }else{
            let nonContact = Contact()
            delegate?.updateContacts(contact,identifier: segueIdentifier,pastContact:nonContact)
        }
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
                 let alert  = UIAlertController(title: "Warning",
                                                message: "You don't have camera",
                                                preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "OK",
                                               style: .default, handler: nil))
                 self?.present(alert, animated: true, completion: nil)
             }
             self?.present(picker,animated: true)
             
         }))
        
         ac.addAction(UIAlertAction(title: "Library", style: .default,
                                    handler: { [weak self] _ in
             self?.present(picker,animated: true)
         }))
         ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
         
         present(ac,animated: true)
        
         
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }

        
        let path = getDocumentsDirectory().appendingPathComponent(imageName)
        currentImage = UIImage(contentsOfFile: path.path)
        imagePerson.image = currentImage
        
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
    
    @objc func keyboardWillShow(notification: NSNotification) {
            
            guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
    
               return
            }
            
            
            var height: CGFloat = 0.0
            
            if let activeTextField = emailTextField {
                
                let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
                let topOfKeyboard = self.view.frame.height - keyboardSize.height
                
                height = bottomOfTextField - topOfKeyboard + 16
            }
            
            self.view.frame.origin.y = 0 - height
            
        }

        @objc func keyboardWillHide(notification: NSNotification) {
            self.view.frame.origin.y = 0
        }
        
        @objc func backgroundTap(_ sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
        }
    
}
    

extension AddContactViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
  
      
}
