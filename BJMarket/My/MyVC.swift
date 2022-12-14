//
//  MyVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/16.
//

import Foundation
import UIKit

//my페이지메인
class MyVC :UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pointBtn: UIButton!
    @IBOutlet weak var bankNum: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var scrollViewAll: UIScrollView!
    
    @IBOutlet weak var topBtn: UIButton!
    let tag: [String] = ["택배","평점","거래내역","팔로워","팔로잉","안전결제","오픈일","본인인증"]
    let getNum: [String] = ["신청/관리","5.0","7","0","1","1","+289","OK"]
    
    override func viewDidLoad() {
        UIsetting()
        
        //컬렉션뷰셀
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        //당겨서새로고침
        scrollViewAll.delegate = self
        scrollViewAll.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        
        //탑버튼쉐도우
        topBtn.layer.shadowColor = UIColor.black.cgColor
        topBtn.layer.shadowOpacity = 0.2
        topBtn.layer.shadowRadius = 2
    }
    
    // 당겨서 새로고침 함수
      @objc func pullToRefresh(_ sender: Any) {

          // 당겨서 새로고침 기능 종료
          self.scrollViewAll.refreshControl?.endRefreshing()
      }
    
    @IBAction func top(_ sender: Any) {
        scrollViewAll.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
    }
    func UIsetting(){
        //포인트버튼
        pointBtn.layer.borderColor = UIColor.systemGray4.cgColor
        pointBtn.layer.borderWidth = 1
        pointBtn.layer.cornerRadius = 6
//        pointBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        //계좌버튼
        bankNum.layer.borderColor = UIColor.systemGray4.cgColor
        bankNum.layer.borderWidth = 1
        bankNum.layer.cornerRadius = 6
        //이벤트
        eventBtn.layer.borderColor = UIColor.systemGray4.cgColor
        eventBtn.layer.borderWidth = 1
        eventBtn.layer.cornerRadius = 6
    }
}

// MARK: - extension
extension MyVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 상단컬렉션뷰 셀설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tag.count
    }
    
    //컬렉션뷰 감속 끝났을 때 현재 페이지 체크
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell


            cell.title.text = tag[indexPath.row]
            cell.detail.text = getNum[indexPath.row]
            return cell
            
    }
}

