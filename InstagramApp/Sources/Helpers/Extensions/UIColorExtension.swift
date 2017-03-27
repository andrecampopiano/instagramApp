//
//  UIColorExtension.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 27/03/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

extension UIColor {

    static func rgb(red:CGFloat, green:CGFloat, blue:CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    
}
