//
//  tabfirstVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/15.
//

import Foundation
import UIKit
import Alamofire
import Kingfisher

class tabFirstVC : UIViewController{
    
    // 모델가져오기
    var pmodel: PModel?
    var presult: PResult?
    
    
    //콜렉션뷰
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        collectionView.register(tabFirstCollectionViewCell.nib(), forCellWithReuseIdentifier: tabFirstCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getTest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
    }
    
    func getTest() {
        let url = "https://dev.wogus4048.shop/app/home/16"
        //LCId=&MCId=&SCId=
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json",
                             "Accept":"application/json",
                             "X-ACCESS-TOKEN" : "eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyX2lkIjoxNiwiaWF0IjoxNjYzNDY2NDE4LCJleHAiOjE2NjQ5Mzc2NDd9.wKdGXYI2FN47zAdHoc4-ptJY6u6QKOZyV548D1tV-pA"
                            ])
        .validate(statusCode: 200..<300)
        .responseJSON() { res in
            switch res.result{
            case .success(_):
                
                guard let jsonObject = try! res.result.get() as? [String :Any] else {
                    print("올바른 응답값이 아닙니다.")
                    return
                }
                
                do{
                    // Any를 JSON으로 변경
                    let dataJSON = try JSONSerialization.data(withJSONObject:try! res.result.get(), options: .prettyPrinted)
                    //
                    // JSON디코더 사용
                    self.pmodel = try JSONDecoder().decode(PModel.self, from: dataJSON)
                    
                    OperationQueue.main.addOperation { // DispatchQueue도 가능.
                        self.collectionView.reloadData()
                       }
                    
                } // 디코딩 에러잡기
                catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                
                
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
            }
        }
    }

}


// MARK: - extension콜렉션뷰
extension tabFirstVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 상단컬렉션뷰 셀설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
//        return self.pmodel?.result.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tabFirstCollectionViewCell.identifier, for: indexPath) as! tabFirstCollectionViewCell
        
        
        // 이미지주소가
         let imgInfo  = self.pmodel?.result[indexPath.item].imgURL
         
         if imgInfo != nil {
             // 킹피셔를 사용한 이미지 처리방법
             if let imageURL = self.pmodel?.result[indexPath.row].imgURL{
                 // 이미지처리방법
                 guard let url = URL(string: imageURL) else {
                     //리턴할 셀지정하기
                     return cell
                 }
                 // cell.postImg.kf.setImage(with:url)
                 cell.imageView.kf.indicatorType = .activity
                 cell.imageView.kf.setImage(
                     with: url,
                     placeholder: UIImage(named: "placeholderImage"),
                     options: [
                         .scaleFactor(UIScreen.main.scale),
                         .transition(.fade(1)),
                         .cacheOriginalImage
                     ])
                 {
                     result in
                     switch result {
                     case .success(_): break
 //                        print("HeratVC 킹피셔 Task done")
                     case .failure(let err):
                         print(err.localizedDescription)
                     }
                 }
             }
         }
//        cell.imageView.image = UIImage(named: "01")
        // cell.imageView.image = UIImage(named: models[indexPath.item].imageName)
        cell.price.text = self.pmodel?.result[indexPath.row].title
        cell.title.text = self.pmodel?.result[indexPath.item].price?.description
//        cell.place.text = self.pmodel?.result[indexPath.item].safepay?.description
        cell.place.text = "서울시 관악구"
        cell.uploadTime.text = "1시간전"
        // 썸네일이미지랜덤표기
        let numbers = Array(1...30);
                 var result: Set<Int> = [];
                 while result.count < 1 {
                     result.insert(numbers.randomElement()!)
                 }
         //set의첫번째값 접근
        cell.heartCount.text = String(result.first!)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 다음 화면 뷰컨트롤러의 인스턴스 생성 (StoryBoardID를 이용하여 참조)
        if let nextScene = self.storyboard?.instantiateViewController(withIdentifier: "productDetailVC" ){
                   nextScene.modalPresentationStyle = .fullScreen
                   // 화면 전환 애니메이션의 타입
                   self.present(nextScene, animated : true)
               }
    }
}
