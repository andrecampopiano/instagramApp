//
//  CustomImageView.swift
//  InstagramApp
//
//  Created by André Campopiano on 02/05/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    var lastUrlUsedToLoadImage:String?

    func loadImage(urlString:String){
        
        lastUrlUsedToLoadImage = urlString
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print("Failed to fetch post image:", err)
            }else{
                if url.absoluteString != self.lastUrlUsedToLoadImage {
                    return
                }
                guard let data = data  else { return }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            }.resume()
    }

}
