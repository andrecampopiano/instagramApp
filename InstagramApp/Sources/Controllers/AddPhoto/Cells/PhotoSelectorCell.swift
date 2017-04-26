//
//  PhotoSelectorCell.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 26/04/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

class PhotoSelectorCell: UICollectionViewCell {
    
    let photoImageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        photoImageView.anchor(top:topAnchor, left: leftAnchor, right: rightAnchor, botton: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBotton: 0, width: 0, height: 0)
        backgroundColor = .purple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
