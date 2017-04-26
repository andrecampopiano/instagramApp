//
//  LoginController.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 25/04/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    let logoContainerView:UIView = {
        let view = UIView()
        let logoImageView = UIImageView(image:#imageLiteral(resourceName: "Instagram_logo_white"))
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, left: nil, right: nil, botton: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBotton: 0, width: 200, height: 50)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        return view
    }()
    
    let emailTextField: TextFieldLogin = {
        let tf = TextFieldLogin()
        tf.placeholder = "Email"
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
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.rgb(red:149,green:204,blue:244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName:UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14), NSForegroundColorAttributeName:UIColor.rgb(red:17,green:154,blue:237)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleDontHaveAccount), for: .touchUpInside)
        return button
    }()
    
    func handleLogin(){
        let authService = AuthService.sharedInstance
        guard let email = emailTextField.text?.trim(), email.characters.count > 0 else { return }
        guard let password = passwordTextField.text?.trim(), password.characters.count > 0 else { return }
        authService.signInAccoutWith(email: email, password: password) { (user, error) in
            if let err = error {
                self.alert(title: "title_attention", message: err.localizedDescription, localizable: true)
            }else {
                self.alert(title: "title_attention", message:"Successfully logged" , localizable: true, completion:{
                    guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else{ return }
                    mainTabBarController.setupViewControllers()
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
    }

    func handleTextInputChange(){
        let isFormValid = emailTextField.text?.characters.count ?? 0 > 0  && passwordTextField.text?.characters.count ?? 0 > 0
        if isFormValid {
            loginButton.backgroundColor = UIColor.rgb(red:17,green:154,blue:237)
            loginButton.isEnabled = true
        }else {
            loginButton.backgroundColor = UIColor.rgb(red:149,green:204,blue:244)
            loginButton.isEnabled = false
        }
    }
    
    func handleDontHaveAccount(){
        let registerController = RegisterController()
        navigationController?.pushViewController(registerController, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, botton: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBotton: 0, width: 0, height: 150)
        setupInputFields()
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, right: view.rightAnchor, botton: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBotton: 0, width: 0, height: 50)
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, botton:nil, paddingTop: 40, paddingLeft: 40, paddingRight: 40, paddingBotton: 0, width:0, height:140)
    }
}
