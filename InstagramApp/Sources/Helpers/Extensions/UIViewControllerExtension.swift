//
//  UIViewControllerExtension.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 25/04/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

extension UIViewController{
    func alert(title:String, message:String, localizable:Bool, completion:(()-> Swift.Void)? = nil){
        var messageTitle = title
        var msg = message
        if localizable {
            messageTitle = NSLocalizedString(messageTitle, comment: "")
            msg = NSLocalizedString(msg, comment: "")
        }
        let alertController = UIAlertController(title: messageTitle, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
