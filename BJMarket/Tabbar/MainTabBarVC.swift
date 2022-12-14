//
//  MainTabBarVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/14.
//

import Foundation
import UIKit

class MainTabBarVC: UITabBarController, UITabBarControllerDelegate{
    
    override func viewDidLoad() {
          super.viewDidLoad()

          self.delegate = self
        
           UITabBar.appearance().tintColor = .black
           /// TabBar의 background 색상
           UITabBar.appearance().backgroundColor = .white

      }
       
      func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
          
          let index = tabBarController.viewControllers?.index(of: viewController)
          
          //검색
          if index == 1 {
              
              let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabSearchVC") as! TabSearchVC
              vc.modalPresentationStyle = .fullScreen
              self.present(vc, animated: true, completion: nil)
              // self.navigationController?.pushViewController(vc, animated: true)
              return false
    
        
          // 등록
          } else if (index == 2) {
              let vc = self.storyboard?.instantiateViewController(withIdentifier: "registerVC") as! registerVC
              vc.modalPresentationStyle = .fullScreen
              self.present(vc, animated: true, completion: nil)

              return false
          } else {
              return true
          }
          
      }

}
