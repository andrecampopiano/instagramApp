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
    
    let topView:UIView = {
        let view = UIView()
        return view
    }()
    
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
    
    let btnMore :UIButton = {
        let button = UIButton()
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let viewContainer:UIView = {
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
        
        return view
    }()
    
    let likeButton:UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let commentButton:UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let sendMessageButton:UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "send").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let bookmarkButton:UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "ribbon").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let captionLabel:UILabel =  {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        let attributedText = NSMutableAttributedString(string: "Username ", attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 14)])
        let comment = "Foi uma festa louca!"
        attributedText.append(NSAttributedString(string: comment, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        return label
        
    }()
    let detailLabel:UILabel =  {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        label.text = "1 week ago"
        return label
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
        topView.anchor(top: viewContainer.topAnchor, left: viewContainer.leftAnchor, right: viewContainer.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 56)
        topView.addSubview(userProfileImageView)
        userProfileImageView.anchor(top: topView.topAnchor, left: topView.leftAnchor, right: nil, bottom: topView.bottomAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 0, paddingBottom: 8, width: 40, height: 0)
        topView.addSubview(labelProfileName)
        labelProfileName.anchor(top: topView.topAnchor, left: userProfileImageView.rightAnchor, right: nil, bottom: topView.bottomAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 0, paddingBottom: 8, width: 0, height: 0)
        
        topView.addSubview(btnMore)
        btnMore.anchor(top: topView.topAnchor, left: labelProfileName.rightAnchor, right: topView.rightAnchor, bottom: topView.bottomAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 5, paddingBottom: 10, width: 30, height: 0)
        
    }
    
    func setupContentView(){
        viewContainer.addSubview(photoImageView)
        photoImageView.anchor(top: topView.bottomAnchor, left: viewContainer.leftAnchor, right: viewContainer.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
    }
    
    func setupBottonView(){
        viewContainer.addSubview(bottomView)
        bottomView.anchor(top: photoImageView.bottomAnchor, left: viewContainer.leftAnchor, right: viewContainer.rightAnchor, bottom: viewContainer.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        setupActionsButtons()
        addSubview(bookmarkButton)
        bookmarkButton.anchor(top: bottomView.topAnchor, left: nil, right: bottomView.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 50, height: 50)
        addSubview(captionLabel)
        captionLabel.anchor(top: bookmarkButton.bottomAnchor, left: bottomView.leftAnchor, right: bottomView.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 10, paddingRight: 10, paddingBottom: 0, width: 0, height: 0)
        addSubview(detailLabel)
        detailLabel.anchor(top: captionLabel.bottomAnchor, left: bottomView.leftAnchor, right: bottomView.rightAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    func setupActionsButtons(){
        let stackView = UIStackView(arrangedSubviews: [likeButton,commentButton,sendMessageButton])
        stackView.distribution = .fillEqually
        bottomView.addSubview(stackView)
        stackView.anchor(top: bottomView.topAnchor, left: bottomView.leftAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 120, height: 50)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
