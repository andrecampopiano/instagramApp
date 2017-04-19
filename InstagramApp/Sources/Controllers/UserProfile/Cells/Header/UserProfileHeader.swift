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
    }
    
    var user: UserProfile? {
        didSet{
             setupProfileImage()
        }
    }
    
    fileprivate func setupProfileImage() {
        guard let profileImageUrl = user?.profileImageUrl else { return }
        guard let url = URL(string: profileImageUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err)
                return
            }
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }.resume()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
