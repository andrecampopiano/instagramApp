//
//  User.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 27/03/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var uid:String!
    var email:String!
    var username:String!
    var profileImageUrl:String!
    
    init(dictionary:[String:Any], uid:String){
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
    }
}
