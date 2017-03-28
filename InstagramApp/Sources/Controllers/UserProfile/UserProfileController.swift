//
//  UserProfileController.swift
//  InstagramApp
//
//  Created by André Campopiano on 27/03/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit
import Firebase
class UserProfileController: UICollectionViewController {
    
    private var user:Users!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        
        fetchUser()
        
    }
    
    fileprivate func fetchUser(){
        guard let uid =  FIRAuth.auth()?.currentUser?.uid else { return }
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let dictionary = snapshot.value as? [String:Any]
            
            print(snapshot.value!)
        }) { (error) in
            print(error)
        }
    }
    
}
