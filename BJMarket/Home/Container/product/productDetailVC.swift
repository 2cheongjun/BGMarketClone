//
//  productDetailVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/18.
//

import Foundation
import UIKit

class productDetailVC :UIViewController,UIScrollViewDelegate{
    
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
    //닫기
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    
    // MARK: - viewdidload
    override func viewDidLoad() {
        collectionView2.delegate = self
        collectionView2.dataSource = self
        let nibName = UINib(nibName: "productCell", bundle: nil)
        collectionView2.register(nibName, forCellWithReuseIdentifier:"productCell")
        
        models.append(Model(text: "1", imageName:"02"))
        models.append(Model(text: "2", imageName:"01"))
        models.append(Model(text: "3", imageName:"04"))
        models.append(Model(text: "4", imageName:"03"))
        
        scrollView.delegate = self
               addContentScrollView()
               setPageControl()
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
    
    
}//클래스끝



// MARK: - extension
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




