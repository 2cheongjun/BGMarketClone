//
//  tableVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/15.
//

import UIKit
import Tabman
import Pageboy

class tableVC : TabmanViewController {
    
    var testStr: String?

    var viewControllers: Array<UIViewController> = []

       override func viewDidLoad() {
           super.viewDidLoad()

           let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
           let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController3") as! ViewController3
               
           viewControllers.append(vc2)
           viewControllers.append(vc3)
           
           self.dataSource = self

           // Create bar
           let bar = TMBar.ButtonBar()
           bar.layout.transitionStyle = .snap // Customize

           // Add to view
           addBar(bar, dataSource: self, at: .top)
       }
}


extension tableVC: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = "Page \(index)"
        item.image = UIImage(named: "image.png")
        // ↑↑ 이미지는 이따가 탭바 형식으로 보여줄 때 사용할 것이니 "이미지가 왜 있지?" 하지말고 넘어가주세요.
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
