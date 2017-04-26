//
//  MainTabBarController.swift
//  InstagramApp
//
//  Created by André Campopiano on 27/03/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController,UITabBarControllerDelegate {
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        var ret = true
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            ret = false
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: UICollectionViewFlowLayout())
            let photoNavController = UINavigationController(rootViewController: photoSelectorController)
            present(photoNavController, animated: true, completion: nil)
        }
        
        return ret
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if FIRAuth.auth()?.currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            return 
        }
        setupViewControllers()
    }
    
    func setupViewControllers(){
        //home
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"))
        //search
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"))
        //plus
        let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"))
        
        //like
        let navLikeController = templateNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"))
        
        //userProfile
        let userProfileController = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        let userProfileNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: userProfileController)
        tabBar.tintColor = .black
        viewControllers = [homeNavController, searchNavController, plusNavController, navLikeController, userProfileNavController]
        
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage:UIImage, selectedImage:UIImage, rootViewController:UIViewController = UIViewController())->UINavigationController{
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
