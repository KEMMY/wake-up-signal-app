//
//  MainTabBarController.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 10/8/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import UIKit
import Firebase


class MainTabBarController: UITabBarController, DataDelegate {
    func sendDriverHeathRecord(_ record: DriverHealthProfile) {
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> DELEGATED INT USERPROFILE CONTROLLER >>>>>>>>>>>>>>>>>>")
        print(record.age)
    }
    
    
    let driver = Driver()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = HealthController()
        vc.delegate = self
        
        if Auth.auth().currentUser == nil {
            //show if not logged in
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            
            return
        }
        
        setupViewControllers()
        WakeUpManager.shared.printDHR()
    }
    
    func setupViewControllers() {
        //health controller
        let healthNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: HealthController(collectionViewLayout: UICollectionViewFlowLayout()))
       healthNavController.title = "Health"
    
        //maps controller
       // let mapNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "map_photo"), selectedImage: #imageLiteral(resourceName: "map_photo_selected"))
        let mapNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "map_photo").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "map_photo_selected").withRenderingMode(.alwaysOriginal), rootViewController: MapController())
        mapNavController.title = "Map"
        // Profile controller
        
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        userProfileNavController.title = "Profile"
        
        userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
    
        tabBar.tintColor = .black
        
        viewControllers = [ healthNavController,
                            userProfileNavController,
                            mapNavController]
        //insets
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}






