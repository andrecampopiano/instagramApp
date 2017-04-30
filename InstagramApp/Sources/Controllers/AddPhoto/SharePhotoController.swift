//
//  SharePhotoController.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 27/04/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit
import Firebase

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
        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else { return }
        guard let idUser = FIRAuth.auth()?.currentUser?.uid else { return }
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let filename = NSUUID().uuidString
        FIRStorage.storage().reference().child("posts").child(idUser).child(filename).put(uploadData, metadata: nil) { (metadata, error) in
            if let err = error {
                self.alert(title: "title_attention", message: "message_error_upload_image", localizable: true , completion: {
                    print(err.localizedDescription)
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    return
                })
            }
            guard let imageUrl = metadata?.downloadURL()?.absoluteString else { return }
            print(NSLocalizedString("message_success_upload_image", comment: ""),imageUrl)
            self.saveToDatabaseWithImageUrl(imageUrl: imageUrl,textPost:self.textView.text,postImage: image)
        }
    }
    
    fileprivate func saveToDatabaseWithImageUrl(imageUrl:String, textPost:String, postImage:UIImage){
        // tratar text sem caracters
        guard let idUser = FIRAuth.auth()?.currentUser?.uid else { return }
        let userPostRef = FIRDatabase.database().reference().child("posts").child(idUser)
        let ref = userPostRef.childByAutoId()
        let values = ["caption": textPost , "imageUrl" : imageUrl, "imageWidth" : postImage.size.width, "imageHeight" : postImage.size.height, "creationDate" : Date().timeIntervalSince1970] as [String : Any]
        ref.updateChildValues(values) { (error, ref) in
            if let err = error {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print(NSLocalizedString("message_failed_save_post", comment: ""), err)
                return
                
            }
            print(NSLocalizedString("message_success_save_post", comment: ""))
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
