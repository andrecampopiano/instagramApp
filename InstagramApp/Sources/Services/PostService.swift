//
//  PostService.swift
//  InstagramApp
//
//  Created by André Campopiano on 01/05/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit
import Firebase

class PostService: NSObject {
    
    static let shareInstance = PostService()
    
    private let refPost = FIRDatabase.database().reference().child("posts")
    
    private override init() { }
    
    func savePostWith(caption:String, postImage:UIImage, completion:@escaping(Bool,Error?)->()){
        guard let userId = FIRAuth.auth()?.currentUser?.uid else { return }
        self.saveImagePost(image: postImage, userId:userId) { (imageUrl, error) in
            if let err = error {
                completion(false,err)
            }else{
                self.saveToDatabaseWithImageUrl(imageUrl: imageUrl, caption: caption, postImage: postImage, userId:userId) {(saved , error) in
                    if let err = error {
                        completion(false, err)
                    }else{
                        completion(true, nil)
                    }
                }
            }
        }
    }
    
    fileprivate func saveImagePost(image:UIImage, userId:String, completion:@escaping(String,Error?)->()){
        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else { return }
        let filename = NSUUID().uuidString
        FIRStorage.storage().reference().child("posts").child(userId).child(filename).put(uploadData, metadata: nil) { (metadata, error) in
            if let err = error {
                completion("", err)
            }else {
                guard let imageUrl = metadata?.downloadURL()?.absoluteString else { return }
                print(NSLocalizedString("message_success_upload_image", comment: ""),imageUrl)
                completion(imageUrl,nil)
            }
        }
    }
    
    fileprivate func saveToDatabaseWithImageUrl(imageUrl: String,caption:String, postImage: UIImage, userId:String, completion:@escaping(Bool,Error?)->()){
        self.refPost.child(userId)
        let ref = self.refPost.childByAutoId()
        let values = ["caption": caption , "imageUrl" : imageUrl, "imageWidth" : postImage.size.width, "imageHeight" : postImage.size.height, "creationDate" : Date().timeIntervalSince1970] as [String : Any]
        ref.updateChildValues(values) { (error, ref) in
            if let err = error {
                print(NSLocalizedString("message_failed_save_post", comment: ""), err)
                completion(false,err)
            }else{
                completion(true,nil)
            }
        }
    }
    
    func fetchAllPosts(completion:@escaping([Post]?, Error?)->()){
        let ref = FIRDatabase.database().reference().child("posts")
        var posts = [Post]()
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String:Any] else { return }
            dictionaries.forEach({ (uid, postsValue) in
                let userService = UserService.shareInstance
                userService.fetchUserWith(uid: uid, completion: { (user, error) in
                    if let err = error {
                        completion(nil,err)
                    }else {
                        if let user = user {
                            (postsValue as! [String:Any]).forEach({(key,value)in
                                guard let dictionary = value as? [String:Any] else { return }
                                let post = Post(user: user, dictionary: dictionary)
                                posts.append(post)
                                
                            })
                            completion(posts,nil)
                        }
                    }
                })
            })
        }) { (error) in
            print(error)
            completion(posts,error)
        }
    }
    
    func fetchPostsUserProfile(user:User){
        func fetchPostsUserProfile(completion:@escaping([Post]?,Error?)->()){
            guard let userId = FIRAuth.auth()?.currentUser?.uid else { return }
            let ref = self.refPost.child(userId)
            var posts = [Post]()
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionaries = snapshot.value as? [String:Any] else { return }
                dictionaries.forEach({ (key, value) in
                    guard let dictionary = value as? [String:Any] else { return }
                    let post = Post(user: user, dictionary: dictionary)
                    posts.append(post)
                })
                completion(posts,nil)
            }) { (error) in
                print(error)
                completion(nil,error)
            }
        }
    }
    /*
     func fetchPosts(completion:@escaping([Post]?, Error?)->()){
     guard let userId = FIRAuth.auth()?.currentUser?.uid else { return }
     let ref = FIRDatabase.database().reference().child("posts")
     var posts = [Post]()
     ref.observeSingleEvent(of: .value, with: { (snapshot) in
     guard let dictionaries = snapshot.value as? [String:Any] else { return }
     dictionaries.forEach({ (key, value) in
     guard let dictionary = value as? [String:Any] else { return }
     let post = Post(user: user, dictionary: dictionary)
     posts.append(post)
     })
     completion(posts,nil)
     }) { (error) in
     print(error)
     completion(nil,error)
     }
     }
     */
    func fetchOrderedPostsUserProfile(user:User, completion:@escaping([Post],Error?)->()){
        //Bug no observer corrigir depois
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        let ref = FIRDatabase.database().reference().child("posts").child(uid)
        var posts = [Post]()
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value  as? [String : Any] else { return }
            //let user = User(dictionary: ["username" : "edivergis"])
            let post = Post(user: user ,dictionary: dictionary)
            posts.append(post)
            completion(posts, nil)
        }) { (error) in
            print("Failed to fetch ordered posts:", error)
            completion(posts,error)
        }
    }
    
    
}
