//
//  HeaderPhotoCell.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 26/04/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

class HeaderPhotoCell: UICollectionViewCell {
    
    let headerImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true        
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerImageView)
        headerImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
