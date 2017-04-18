//
//  UserProfileHeader.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 28/03/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

class UserProfileHeader: UICollectionViewCell {
    
    var urlString:String!
    
    let profileImageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .black
        iv.layer.cornerRadius = 40
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, right: nil, botton: nil, paddingTop: 12, paddingLeft: 12, paddingRight: 0, paddingBotton: 0, width: 80, height: 80)
        setupProfileImage()
    }
    var user: User? {
        didSet{
            print("Did set \(user?.username)")
        }
    }
    
    
    fileprivate func setupProfileImage() {
        
       
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let err = error {
                    print(err)
                    return
                }
                if let imageData = data {
                    self.profileImageView.image = UIImage(data:imageData)
                }
            }.resume()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
