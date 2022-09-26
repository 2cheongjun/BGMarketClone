//
//  iconVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/15.
//

import UIKit
import Tabman
import Pageboy

class myTabVC :TabmanViewController {
    
    
    var viewControllers: Array<UIViewController> = []

       override func viewDidLoad() {
           super.viewDidLoad()

           //뷰컨2개 넣어주기
           let vc1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myTabSellVC") as! myTabSellVC
           let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myTabShopVC") as! myTabShopVC
           let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myTabLikeVC") as! myTabLikeVC
        
           viewControllers.append(vc1)
           viewControllers.append(vc2)
           viewControllers.append(vc3)
           
           self.dataSource = self

           // Create bar
           let bar = TMBar.ButtonBar()
           bar.layout.transitionStyle = .snap // Customize
           bar.backgroundView.style = .blur(style: .regular)
//           bar.layout.alignment = .centerDistributed //중앙정렬
           bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 00.0)
           // 버튼컬러
           bar.buttons.customize { (button) in
               button.tintColor = .gray
               button.selectedTintColor = .black
           }
           //인디케이터
//           bar.indicator.weight = .heavy
           bar.indicator.tintColor = .black
           bar.indicator.overscrollBehavior = .bounce//오버스크롤동작
           // Add to view
           addBar(bar, dataSource: self, at: .top)// 안보이게하려면 지움
       }
}

extension myTabVC: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        
//        let item = TMBarItem(title:"")
//        item.title = "Page \(index)"
//        item.title = ""
//        item.image = UIImage(named: "bar1.png")
//        return item
        // ↑↑ 이미지는 이따가 탭바 형식으로 보여줄 때 사용할 것이니 "이미지가 왜 있지?" 하지말고 넘어가주세요.
        // MARK: - Tab 안 글씨들
        switch index {
        case 0:
            return TMBarItem(title: "판매상품")
        case 1:
            return TMBarItem(title: "상점후기")
        case 2:
            return TMBarItem(title: "찜목록")

        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }

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

