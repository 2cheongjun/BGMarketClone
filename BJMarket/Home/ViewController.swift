//
//  ViewController.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/14.
//

import UIKit

class ViewController: UIViewController{

    //상단컬렉션뷰
    @IBOutlet weak var collectionView: UICollectionView!
    // 현재페이지 체크 변수 (자동 스크롤할 때 필요)
    var nowPage: Int = 0
    var models = [Model]()
    
    //중간컬렉션뷰
    @IBOutlet weak var McollectionView: UICollectionView!
    
//    let tag: [String] = ["같이해요","동네질문","동네맛집","동네소식","취미생활","실시간동네날씨","분실/실종센터"]

    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 이미지예제(컬렉션뷰에 들어가는 모델데이터)
        models.append(Model(text: "1", imageName:"02"))
        models.append(Model(text: "2", imageName:"01"))
        models.append(Model(text: "3", imageName:"04"))
        models.append(Model(text: "4", imageName:"03"))

        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        bannerTimer()
    }
    
    // MARK: - 배너움직임
    // 2초마다 실행되는 타이머
       func bannerTimer() {
           let _: Timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
               self.bannerMove()
           }
       }
       // 배너 움직이는 매서드
       func bannerMove() {
           // 현재페이지가 마지막 페이지일 경우
           if nowPage == models.count-1 {
           // 맨 처음 페이지로 돌아감
               collectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
               nowPage = 0
               return
           }
           // 다음 페이지로 전환
           nowPage += 1
           collectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
       }
}//클래스끝


// MARK: - extension
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

// 상단컬렉션뷰 셀설정
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return models.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
    
//        cell.imageView.image = UIImage(named: "01")
    cell.imageView.image = UIImage(named: models[indexPath.item].imageName)
    cell.label.text = models[indexPath.item].text + "/4"
    return cell
}

//    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize{
//
//        return CGSize(width: 80, height: 40)
//    }

//컬렉션뷰 감속 끝났을 때 현재 페이지 체크
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
