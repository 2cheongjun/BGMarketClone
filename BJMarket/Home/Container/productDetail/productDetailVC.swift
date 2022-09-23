//
//  productDetailVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/18.
//

import Foundation
import UIKit
import FloatingPanel

class productDetailVC :UIViewController,UIScrollViewDelegate{
    
    var fpc: FloatingPanelController!
    var contentsVC: ContentsVC! // 띄울 VC
    
    //상단이미지
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var images = [UIImage(named: "01"),UIImage(named: "02"),UIImage(named: "03")]
    var imageViews = [UIImageView]()
    
    var models = [Model]()

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPlace: UILabel!
    @IBOutlet weak var prductTime: UILabel!
    //배너테두리넣기
    @IBOutlet weak var banner: UIButton!
    //제품설명
    @IBOutlet weak var productDescription: UITextView!
    //이상점의 상품(테이블뷰)
    @IBOutlet weak var collectionView2: UICollectionView!
    //작성자
    @IBOutlet weak var userName: UILabel!
    //상품전체보기
    @IBOutlet weak var productViewAllBtn: UIButton!
    //리뷰테이블뷰(컬렉션)
    @IBOutlet weak var tableView: UITableView!
    //리뷰전체보기
    @IBOutlet weak var reviewAllBtn: UIButton!
    @IBOutlet weak var scrollViewAll: UIScrollView!
    //닫기
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //탑버튼
    @IBOutlet weak var topBtn: UIButton!
    
    // MARK: - viewdidload
    override func viewDidLoad() {
        models.append(Model(text: "1", imageName:"02"))
        models.append(Model(text: "2", imageName:"01"))
        models.append(Model(text: "3", imageName:"04"))
        models.append(Model(text: "4", imageName:"03"))
        
        //상단스크롤이미지
        scrollView.delegate = self
        addContentScrollView()
        setPageControl()
        
        //상점제품
        collectionView2.delegate = self
        collectionView2.dataSource = self
        let nibName = UINib(nibName: "productCell", bundle: nil)
        collectionView2.register(nibName, forCellWithReuseIdentifier:"productCell")
        
        //상점후기
        tableView.delegate = self
        tableView.dataSource = self
        let nibName2 = UINib(nibName: "reviewCell", bundle: nil)
        tableView.register(nibName2, forCellReuseIdentifier:"reviewCell")
        
        //탑버튼쉐도우
        topBtn.layer.shadowColor = UIColor.black.cgColor
        topBtn.layer.shadowOpacity = 0.2
        topBtn.layer.shadowRadius = 2
        
    }
    
    // MARK: - 이미지스크롤
    private func addContentScrollView() {
           for i in 0..<images.count {
               let imageView = UIImageView()
               let xPos = scrollView.frame.width * CGFloat(i)
               imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
               imageView.image = images[i]
               scrollView.addSubview(imageView)
               scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
           }
       }
    
    private func setPageControl() {
           pageControl.numberOfPages = images.count
       }
    
    private func setPageControlSelectedPage(currentPage:Int) {
           pageControl.currentPage = currentPage
       }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          let value = scrollView.contentOffset.x/scrollView.frame.size.width
          setPageControlSelectedPage(currentPage: Int(round(value)))
      }
    
    //MARK: -탑버튼액션
    @IBAction func top(_ sender: Any) {
        scrollViewAll.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
    }
    //상품전체보기
    @IBAction func productAllBtn(_ sender: Any) {
    }
    //결제버튼
    @IBAction func payBtn(_ sender: Any) {
        //바텀시트띄우기
        setupView()
    }
    
    private func setupView() {
        contentsVC = storyboard?.instantiateViewController(identifier: "ContentsVC", creator: { (coder) -> ContentsVC? in
            return ContentsVC(coder: coder)
        })
        fpc = FloatingPanelController()
        fpc.changePanelStyle() // panel 스타일 변경 (대신 bar UI가 사라지므로 따로 넣어주어야함)
        fpc.delegate = self
        fpc.set(contentViewController: contentsVC) // floating panel에 삽입할 것
        fpc.track(scrollView: contentsVC.tbl)
        fpc.addPanel(toParent: self) // fpc를 관리하는 UIViewController
        fpc.layout = MyFloatingPanelLayout()
        fpc.invalidateLayout() // if needed
    }
    
}//클래스끝

extension FloatingPanelController {
    func changePanelStyle() {
        let appearance = SurfaceAppearance()
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor.black
        shadow.offset = CGSize(width: 0, height: -4.0)
        shadow.opacity = 0.15
        shadow.radius = 2
        appearance.shadows = [shadow]
        appearance.cornerRadius = 15.0
        appearance.backgroundColor = .clear
        appearance.borderColor = .clear
        appearance.borderWidth = 0

        surfaceView.grabberHandle.isHidden = true
        surfaceView.appearance = appearance

    }
}

extension productDetailVC: FloatingPanelControllerDelegate {
    func floatingPanelDidChangePosition(_ fpc: FloatingPanelController) {
        if fpc.state == .full {

        } else {

        }
    }
}

class MyFloatingPanelLayout: FloatingPanelLayout {

    var position: FloatingPanelPosition {
        return .bottom
    }

    var initialState: FloatingPanelState {
        return .half
    }

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] { // 가능한 floating panel: 현재 full, half만 가능하게 설정
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 292, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}


// MARK: - 컬렉션뷰
extension productDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 상단컬렉션뷰 셀설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCell.identifier, for: indexPath) as! productCell


            //        cell.imageView.image =
//        UIImage(named: models[indexPath.item].imageName)
            cell.mImgView.image = UIImage(named: "01")
            cell.pdTitle.text = "오일스프레이 고압스프레이새상품"
            return cell
    }
}

// MARK: - 테이블뷰
extension productDetailVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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
//        cell.reviewText.text =""
//        cell.userID.text =
//        cell.when.text =
//            cell.mImgView.image =  UIImage(named: "01")
//            cell.mImgView.image = UIImage(named: models[indexPath.item].imageName)
//            cell.pdTitle.text = ""
            return cell
    }
}


