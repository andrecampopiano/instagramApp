//
//  UIViewExtension.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 27/03/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

extension UIView {

    func anchor(top:NSLayoutYAxisAnchor?, left:NSLayoutXAxisAnchor? , right:NSLayoutXAxisAnchor?,botton:NSLayoutYAxisAnchor?, paddingTop: CGFloat, paddingLeft:CGFloat, paddingRight:CGFloat, paddingBotton:CGFloat,  width:CGFloat , height:CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
             topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let left = left{
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
       
        if let botton = botton {
            self.bottomAnchor.constraint(equalTo: botton, constant: paddingBotton).isActive = true
        }
        
        if  height != 0 {
             heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if  width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
        
}
