//
//  ViewController.swift
//  InstagramApp
//
//  Created by André Campopiano on 27/03/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit
import Firebase

class RegisterController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        return button
    }()

    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        tf.autocapitalizationType = .none
        
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.autocapitalizationType = .none
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.autocapitalizationType = .none
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.rgb(red:149,green:204,blue:244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        button.isEnabled = false
        
        return button
    }()
    
    func handleTextInputChange(){
        
        let isFormValid = emailTextField.text?.characters.count ?? 0 > 0 && usernameTextField.text?.characters.count ?? 0 > 0 && passwordTextField.text?.characters.count ?? 0 > 0
        if isFormValid {
            signUpButton.backgroundColor = UIColor.rgb(red:17,green:154,blue:237)
            signUpButton.isEnabled = true
        }else {
            signUpButton.backgroundColor = UIColor.rgb(red:149,green:204,blue:244)
            signUpButton.isEnabled = false
        }
    }
    
    func handleAddPhoto(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            addPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            addPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal) , for: .normal)
        }
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.width/2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.layer.borderColor = UIColor.rgb(red:149,green:204,blue:244).cgColor
        addPhotoButton.layer.borderWidth = 4
        dismiss(animated: true, completion: nil)
    }
    
    func handleSignUp(){
        
        guard let email = emailTextField.text?.trim(), email.characters.count > 0 else { return }
        guard let username = usernameTextField.text?.trim(), username.characters.count > 0 else { return }
        guard let password = passwordTextField.text?.trim(), password.characters.count > 0 else { return }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if let err = error  {
                print(err.localizedDescription)
                return
            }
            
            guard let image = self.addPhotoButton.imageView?.image else { return }
            
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
            
            
            let filename = NSUUID().uuidString
            FIRStorage.storage().reference().child("profile_images").child(filename).put(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if let err = error {
                    print("Falha ao carregar a imagem: ", err)
                    return
                }
                
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
                print("Sucesso ao carregar a imagem", profileImageUrl)
                guard let uid = user?.uid else { return }
                
                let dicitionaryValues = ["email":email, "username":username, "password":password ,"urlImage":profileImageUrl]
                
                let values = [uid:dicitionaryValues]
                
                FIRDatabase.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (error, reference) in
                    if let err = error {
                        print(err.localizedDescription)
                        return
                    }
                    
                    print("Sucesso ao salvar usuario ")
                    
                })
                
                
                
            })
            
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(addPhotoButton)
        
        addPhotoButton.anchor(top: view.topAnchor, left: nil, right: nil, botton: nil, paddingTop: 40, paddingLeft: 0, paddingRight: 0, paddingBotton: 0, width: 140, height: 140)
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupInputFields()
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        
        
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.anchor(top: addPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, botton:nil, paddingTop: 20, paddingLeft: 40, paddingRight: 40, paddingBotton: 0, width:0, height:200)
        
        
    }
    
    
}

