//
//  SharePhotoController.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 27/04/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

class SharePhotoController: UIViewController {
    
    let imageView:UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "profile_selected")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        setupNavigationButtons()
        setupImageAndTextViews()
    }
    
    fileprivate func setupImageAndTextViews(){
        let containerView = UIView()
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        containerView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, botton: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBotton: 0, width: 0, height: 100)
        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: nil, botton: containerView.bottomAnchor, paddingTop: 5, paddingLeft: 5, paddingRight: 0, paddingBotton: -5, width: 90, height: 0)
    }
    
    fileprivate func setupNavigationButtons(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("title_share", comment: ""), style: .plain, target: self, action: #selector(handleShare))
    }
    
    func handleShare(){
        print("compartilhagram")
    }
    
    override var prefersStatusBarHidden: Bool{ return true }
}
