//
//  HomeViewCell.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 02/05/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

class HomeViewCell: UICollectionViewCell {
    
    var post:Post? {
        didSet{
            guard let imageUrl = post?.imageUrl else { return }
            photoImageView.loadImage(urlString: imageUrl)
        }
    }
    
    let userProfileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    let labelProfileName:UILabel = {
        let lbl = UILabel()
        lbl.text = "username"
        lbl.font = UIFont.boldSystemFont(ofSize:14)
        return lbl
    }()
    
    let viewContainer:UIView = {
        let view = UIView()
        return view
    }()
    
    let topView:UIView = {
        let view = UIView()
        return view
    }()
    
    let photoImageView:CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let bottomView:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCell()
    }
    
    func setupViewCell(){
        addSubview(viewContainer)
        viewContainer.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        setupTopView()
        setupContentView()
        setupBottonView()
    }
    
    func setupTopView(){
        viewContainer.addSubview(topView)
        topView.anchor(top: viewContainer.topAnchor, left: viewContainer.leftAnchor, right: viewContainer.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 50)
        topView.addSubview(userProfileImageView)
        userProfileImageView.anchor(top: topView.topAnchor, left: topView.leftAnchor, right: nil, bottom: topView.bottomAnchor, paddingTop: 5, paddingLeft: 5, paddingRight: 0, paddingBottom: 5, width: 40, height: 0)
        topView.addSubview(labelProfileName)
        labelProfileName.anchor(top: topView.topAnchor, left: userProfileImageView.rightAnchor, right: nil, bottom: topView.bottomAnchor, paddingTop: 5, paddingLeft: 5, paddingRight: 0, paddingBottom: 5, width: 0, height: 0)
        
    }
    
    func setupContentView(){
        viewContainer.addSubview(photoImageView)
        photoImageView.anchor(top: topView.bottomAnchor, left: viewContainer.leftAnchor, right: viewContainer.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: self.frame.height * 0.6)
    }
    
    func setupBottonView(){
        viewContainer.addSubview(bottomView)
        bottomView.anchor(top: photoImageView.bottomAnchor, left: viewContainer.leftAnchor, right: viewContainer.rightAnchor, bottom: viewContainer.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
