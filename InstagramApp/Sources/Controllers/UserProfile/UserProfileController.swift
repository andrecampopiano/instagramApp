//
//  UserProfileController.swift
//  InstagramApp
//
//  Created by André Campopiano on 27/03/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit
import Firebase
class UserProfileController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    private var userDictionary = [String:Any]()
    private let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchUser()
        collectionView?.backgroundColor = .white
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! UserProfileHeader
        header.backgroundColor = UIColor.green
        header.user = self.user
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let size = CGSize(width: view.frame.width, height: 200)
        return size
    }
    
    var user:UserProfile?
    
    fileprivate func fetchUser(){
        guard let uid =  FIRAuth.auth()?.currentUser?.uid else { return }
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            self.userDictionary = dictionary
            self.user = UserProfile(dictionary: dictionary)
            
            self.navigationItem.title = self.user?.username
            self.collectionView?.reloadSections([0])
        }) { (error) in
            print(error)
        }
    }
    
}

struct UserProfile {
    let username: String
    let profileImageUrl: String
    
    init(dictionary:[String:Any]){
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String  ?? ""
    }
}
