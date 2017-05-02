//
//  SharePhotoController.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 27/04/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

class SharePhotoController: UIViewController {
    
    var selectedImage: UIImage?{
        didSet{
            if let selectedImage = selectedImage{
                self.imageView.image = selectedImage
            }
        }
    }
    
    let imageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        setupNavigationButtons()
        setupImageAndTextViews()
    }
    
    override var prefersStatusBarHidden: Bool{ return true }
    
    fileprivate func setupImageAndTextViews(){
        let containerView = UIView()
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        containerView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, botton: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBotton: 0, width: 0, height: 100)
        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: nil, botton: containerView.bottomAnchor, paddingTop: 5, paddingLeft: 5, paddingRight: 0, paddingBotton: 5, width: 90, height: 0)
        
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, right: containerView.rightAnchor, botton: containerView.bottomAnchor, paddingTop: 5, paddingLeft: 5, paddingRight: 5, paddingBotton: 5, width: 0, height: 0)
    }
    
    fileprivate func setupNavigationButtons(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("title_share", comment: ""), style: .plain, target: self, action: #selector(handleShare))
    }
    
    func handleShare(){
        guard let image = selectedImage else { return }
        guard let caption = self.textView.text, caption.characters.count > 0 else { return }
        let postService = PostService.shareInstance
        navigationItem.rightBarButtonItem?.isEnabled = false
        postService.savePostWith(caption: caption, postImage: image) { (saved, error) in
            if let err = error {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.alert(title: "Attention", message: err.localizedDescription, localizable: false)
            }else {
                self.alert(title: "title_attention", message: "message_success_save_post", localizable: true, completion:{
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
}
