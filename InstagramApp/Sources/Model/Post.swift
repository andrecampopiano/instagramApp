//
//  Post.swift
//  InstagramApp
//
//  Created by André Campopiano on 01/05/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

struct Post {
    let imageUrl:String
    let caption:String
    let imageHeight:Float
    let imageWidth:Float
    let creationDate:NSNumber
    
    init(dictionary:[String:Any]){
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.imageHeight = dictionary["imageHeight"] as! Float
        self.imageWidth = dictionary["imageWidth"] as! Float
        self.creationDate = dictionary["creationDate"] as! NSNumber
    }
}

/*
class Post: NSObject {
    var caption:String!
    var imageUrl:String!
    var imageHeight:Float!
    var imageWidth:Float!
    var creationDate:Date!
}
*/
