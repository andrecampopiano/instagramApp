//
//  StringExtension.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 27/03/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit


extension String {
    
    func trim()->String{
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
}
