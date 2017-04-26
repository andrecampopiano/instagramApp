//
//  RegisterController.swift
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

    let emailTextField: TextFieldLogin = {
        let tf = TextFieldLogin()
        tf.placeholder = "Email"
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let usernameTextField: TextFieldLogin = {
        let tf = TextFieldLogin()
        tf.placeholder = "Username"
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: TextFieldLogin = {
        let tf = TextFieldLogin()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
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
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName:UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14), NSForegroundColorAttributeName:UIColor.rgb(red:17,green:154,blue:237)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleAlreadyHaveAccount), for: .touchUpInside)
        return button
    }()
    
    func handleAlreadyHaveAccount() {
        navigationController?.popViewController(animated: true)
    }
    
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
        guard let image = self.addPhotoButton.imageView?.image else { return }
        let authService = AuthService.sharedInstance
        authService.registerUserWith(email: email, password: password, image:image, username:username) { (saved, error) in
            if let err = error {
                self.alert(title: "title_attention", message: err.localizedDescription,localizable: true, completion: nil)
            }else {
                self.alert(title: "title_attention", message: "message_user_saved",localizable:true, completion: {
                    guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else{ return }
                    mainTabBarController.setupViewControllers()
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(addPhotoButton)
        addPhotoButton.anchor(top: view.topAnchor, left: nil, right: nil, botton: nil, paddingTop: 40, paddingLeft: 0, paddingRight: 0, paddingBotton: 0, width: 140, height: 140)
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setupInputFields()
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, right: view.rightAnchor, botton: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBotton: 0, width: 0, height: 50)
        
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

