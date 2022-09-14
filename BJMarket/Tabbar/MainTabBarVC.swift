//
//  MainTabBarVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/14.
//

import Foundation
import UIKit

class MainTabBarVC: UITabBarController{
    
    deinit{
        print("maintabbarVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .black //아이콘색
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .gray
    }
}
