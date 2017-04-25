//
//  LoginController.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 25/04/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    let sigUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? Sign Up.", for: .normal)
        button.addTarget(self, action: #selector(handleShowSingUp), for: .touchUpInside)
        return button
    }()
    
    func handleShowSingUp(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(sigUpButton)
        sigUpButton.anchor(top: nil, left: view.leftAnchor, right: view.rightAnchor, botton: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBotton: 0, width: 0, height: 50)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
