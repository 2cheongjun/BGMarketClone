//
//  myTabShopVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/16.
//

import UIKit
import Alamofire

class myTabShopVC : UIViewController {
    

    
    let review :[String] = ["발송도 빨리해주시고 친절하고 좋은판매자입니다.잘사용하겠습니다.즐거운밤되세요","다시 거래하고싶은 상점1위⭐️⭐️⭐️⭐️⭐️", "빠른 배송과 친절한 대응 감사합니다.여러번 질문했는데 대응잘해주셔서감사합니다.", "배송잘받았고 잘사용중입니다. 오래잘썼으면 좋겠어요.행쇼~~","구매자님 너무 친절하셔서 쿨거래고 판매하였습니다. 캠핑가서 잘쓸꼐요 감사합니다.~~"]
    let tmpId:[String] = ["독산동물주먹","바이킹","주사인볼트","해그리드","시크릿주주"]
    let time:[String] = ["1일전","3일전","7일전","1개월전","3개월전"]
    

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        //상점후기
        tableView.delegate = self
        tableView.dataSource = self
        let nibName2 = UINib(nibName: "reviewCell", bundle: nil)
        tableView.register(nibName2, forCellReuseIdentifier:"reviewCell")
    }
    
   
    
}


// MARK: - 테이블뷰
extension myTabShopVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // 셀 높이 컨텐츠에 맞게 자동으로 설정// 컨텐츠의 내용높이 만큼이다.
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택한것 눌렸다가 자연스럽게 흰색으로 전환
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! reviewCell

        cell.rate.text = "5.0"
        cell.reviewText.text = review[indexPath.item]
        cell.userID.text = tmpId[indexPath.item]
//        cell.when.text =
//            cell.mImgView.image =  UIImage(named: "01")
//            cell.mImgView.image = UIImage(named: models[indexPath.item].imageName)
//            cell.pdTitle.text = ""
            return cell
    }
}
