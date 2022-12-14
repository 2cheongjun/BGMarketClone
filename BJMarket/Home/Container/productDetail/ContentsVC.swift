//
//  ContentsVC.swift
//  testtest
//
//  Created by 김종권 on 2021/02/04.
//

import Foundation
import UIKit

class ContentsVC: UIViewController {

    @IBOutlet weak var DeliveryDeal: UIButton!
    @IBOutlet weak var DirectDeal: UIButton!
    
    @IBOutlet weak var check1: UIImageView!
    @IBOutlet weak var check2: UIImageView!
    
    // 체크박스 Images
//    let checkedImage = UIImage(named: "radioOn")! as UIImage
//    let uncheckedImage = UIImage(named: "radioOff")! as UIImage
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupView()
        
        //택배버튼설정
        DeliveryDeal.layer.borderColor = UIColor.systemRed.cgColor
        DeliveryDeal.layer.borderWidth = 1
        DeliveryDeal.layer.cornerRadius = 6
        check1.image =  UIImage(named: "radioOn")
        
        //직거래
        DirectDeal.layer.borderColor = UIColor.systemGray6.cgColor
        DirectDeal.layer.borderWidth = 1
        DirectDeal.layer.cornerRadius = 6
        check2.image =  UIImage(named:"radioOff")
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //택배
    @IBAction func Deilvery(_ sender: Any) {
        //직거래
        DirectDeal.layer.borderColor = UIColor.systemGray6.cgColor
        DeliveryDeal.layer.borderColor = UIColor.systemRed.cgColor
        check1.image =  UIImage(named: "radioOn")
        check2.image =  UIImage(named:"radioOff")
    }
    
    
    //직거래
    @IBAction func Direct(_ sender: Any) {
        //택배버튼설정
        DeliveryDeal.layer.borderColor = UIColor.systemGray6.cgColor
        DirectDeal.layer.borderColor = UIColor.systemRed.cgColor
        check1.image =  UIImage(named: "radioOff")
        check2.image =  UIImage(named:"radioOn")
    }
    
    //다음버튼
    @IBAction func NextBtn(_ sender: Any) {
//    if let nextScene = self.storyboard?.instantiateViewController(withIdentifier: "EndVC" ){
//               nextScene.modalPresentationStyle = .fullScreen
//               // 화면 전환 애니메이션의 타입
//               self.present(nextScene, animated : true)
//           }
    }
    

//    private func setupView() {
//        tbl.delegate = self
//        tbl.dataSource = self
////        tbl.register(UINib(nibName: "cell", bundle: nil), forCellReuseIdentifier: "cell")
//    }
}

//extension ContentsVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//        return cell!
//    }
//
//}
