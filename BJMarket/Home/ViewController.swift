//
//  ViewController.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/14.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var searchModel : SearchModel?
    var word = ""
    
    // 모델가져오기
    var pModel: PModel?
//    var pResult: PResult?
    // 모델가져오기
//    var feedModel: FeedModel?
    //피드 모델에 값이 있으면 가져온다.
    var page = ""
    
    //스크롤뷰시사용
    var lastContentOffset: CGFloat = 0.0
    //검색창메뉴영역
    @IBOutlet weak var TopNaviBg: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var search: UIButton!
    @IBOutlet weak var bell: UIButton!
    
    
    @IBAction func test(_ sender: Any) {
    if let nextScene = self.storyboard?.instantiateViewController(withIdentifier: "registerDetailVC" ){
              nextScene.modalPresentationStyle = .fullScreen
              // 화면 전환 애니메이션의 타입
              self.present(nextScene, animated : true)
          }
    }
    
    
    
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
        models.append(Model(text: "1", imageName:"02",dec:""))
        models.append(Model(text: "2", imageName:"01",dec:""))
        models.append(Model(text: "3", imageName:"04",dec:""))
        models.append(Model(text: "4", imageName:"03",dec:""))
        
        //상단컬렉션뷰셀
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //배너무빙
        bannerTimer()

      }// 뷰디드끝
    
   
    
 
    // MARK: - 검색창띄우기(풀)
    @IBAction func search(_ sender: Any) {
        guard let searchVC = self.storyboard?.instantiateViewController(identifier: "TabSearchVC") as? TabSearchVC else { return }
        searchVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(searchVC, animated: true, completion: nil)
    }
    
    // MARK: - 스크롤시페이징/에니메이션?????
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 에니메이션설정
        UIView.animate(withDuration: 0.75) {
            self.view.layoutIfNeeded()
//            self.idSearchArea.alpha = 1.0
        }
        
        if(scrollView.contentOffset.y == 100 ){
            // 그렇지 않으면 버튼 숨김
//            idSearchArea.isHidden = true
//            TopNaviBg.backgroundColor = .black
            TopNaviBg.backgroundColor = .white
        }
        else{
            // 버튼을 보이게 함
//            idSearchArea.isHidden = false
        }
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
    
    // MARK: - 하단테이블뷰로 값전달할때
    //ContainerView 의 ViewDidLoad보다 먼저 실행
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //storyboard에서 설정한 identifier와 동일한 이름
        if segue.identifier == "embedContainer" {
            let tableVC = segue.destination as! tableVC
            //               containerVC.testStr = "Value from Prepare: \(containerValue)"
        }
    }
}//뷰컨끝


// MARK: - extension
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 상단컬렉션뷰 셀설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    //컬렉션뷰 감속 끝났을 때 현재 페이지 체크
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell


            //        cell.imageView.image = UIImage(named: "01")
            cell.imageView.image = UIImage(named: models[indexPath.item].imageName)
            cell.label.text = models[indexPath.item].text + "/4"
            return cell
            
    }
}

