//
//  fillterVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/25.
//

import Foundation
import UIKit

class fillterVC : ViewController {
    
    @IBOutlet weak var acc: UIButton!
    @IBOutlet weak var low: UIButton!
    @IBOutlet weak var high: UIButton!
    
    // 노티1.시작의 시작등록.글수정후에 메인피드를 새로고침하기위한 노티
    let lowfillter: Notification.Name = Notification.Name("lowfillter")
    // 노티1.시작의 시작등록.글수정후에 메인피드를 새로고침하기위한 노티
    let highfillter: Notification.Name = Notification.Name("highfillter")
    
    override func viewDidLoad() {
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonAction))
//        lowprice.addGestureRecognizer(tapGestureRecognizer)
        low.tintColor = UIColor.systemGray6
        high.tintColor = UIColor.systemGray6

    }
    
    //정확도순
    @IBAction func accBtn(_ sender: Any) {
        print("정확도순 버튼이 눌렸습니다.")
    }
    
    //낮은가격순
    @IBAction func lowBTn(_ sender: Any) {
        print("낮은가격순 버튼이 눌렸습니다.")
        //버튼색 컬러
        // 노티2.창이 닫힐때 노티를 메인피드로 신호를 보낸다.
        NotificationCenter.default.post(name: lowfillter, object: "nil", userInfo: nil)
        // 노티1.시작의 시작등록.글수정후에 메인피드를 새로고침하기위한 노티
        low.tintColor = UIColor.systemRed
        high.tintColor = UIColor.systemGray6
        //닫기
        self.dismiss(animated: true, completion: nil)//뷰컨닫기
    }
    
    
    //높은가격순
    @IBAction func highBtn(_ sender: Any) {
        print("높은가격순 버튼이 눌렸습니다.")
        low.tintColor = UIColor.systemGray6
        high.tintColor = UIColor.systemRed
        //버튼색 컬러
        // 노티2.창이 닫힐때 노티를 메인피드로 신호를 보낸다.
        NotificationCenter.default.post(name: highfillter, object: "nil", userInfo: nil)
        
        //닫기
        self.dismiss(animated: true, completion: nil)//뷰컨닫기
    }
}
