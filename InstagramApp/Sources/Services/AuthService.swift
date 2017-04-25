//
//  AuthService.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 25/04/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit
import Firebase

class AuthService: NSObject {
    
    static let sharedInstance = AuthService()
    private override init(){ }
    
    func registerUserWith(email:String, password:String, image:UIImage, username:String,  completion:@escaping(Bool,Error?)->()){
        self.createUserWith(email: email, password: password) { (user, error) in
            if let err = error{ completion(false,err)
            }else{
                self.saveImageProfile(image: image, completion: { (profileImageUrl,error) in
                    if let err = error { completion(false,err)
                    }else {
                        guard let uid = user?.uid else { return }
                        let dicitionaryValues = ["email":email, "username":username, "password":password ,"profileImageUrl":profileImageUrl]
                        let values = [uid:dicitionaryValues]
                        self.saveDataUser(userDictionary: values, completion: { (saved, error) in
                            if let err = error { completion(false,err) }else{ completion(true,nil)}
                        })
                    }
                })
            }
        }
    }
    
    func createUserWith(email:String, password:String, completion:@escaping(FIRUser?,Error?)->()){
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let err = error  { completion(nil, err) }else { completion(user, nil) }
        })
    }
    
    func saveImageProfile(image:UIImage, completion:@escaping(String,Error?) ->()){
        guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
        let filename = NSUUID().uuidString
        FIRStorage.storage().reference().child("profile_images").child(filename).put(uploadData, metadata: nil, completion: { (metadata, error) in
            if let err = error { completion("",err)
            }else {
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
                completion(profileImageUrl,nil)
            }
        })
    }
    
    func saveDataUser(userDictionary:[String:[String:String]], completion:@escaping(Bool,Error?)->()){
        FIRDatabase.database().reference().child("users").updateChildValues(userDictionary, withCompletionBlock: { (error, reference) in
            if let err = error { completion(false,err) }else{ completion(true,nil)
            }
        })
    }
}
