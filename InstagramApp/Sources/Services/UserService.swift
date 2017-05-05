//
//  UserService.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 05/05/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit
import Firebase

class UserService: NSObject {
    
    static let shareInstance = UserService()
    private let refUser = FIRDatabase.database().reference().child("users")
    
    private override init() { }
    
    func fetchUserProfileLogged(completion:@escaping(User?, Error?)->()){
        guard let uid =  FIRAuth.auth()?.currentUser?.uid else { return }
        fetchUserWith(uid: uid, completion: completion)
    }
    
    func fetchUserWith(uid:String, completion:@escaping(User?,Error?)->()){
        refUser.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            let user = User(dictionary: dictionary, uid: uid)
            completion(user, nil)
        }) { (error) in
            completion(nil, error)
        }
    }
}
