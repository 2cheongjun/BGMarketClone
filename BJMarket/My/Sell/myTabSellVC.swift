//
//  myTabSellVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/16.
//

import UIKit
import Alamofire

class myTabSellVC : UIViewController{
    var newModel : NewModel?
    var newresult : NewResult?

    let plist = UserDefaults.standard
    
    @IBOutlet weak var fillterBtn: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBg: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        UIsetting()
        
        //컬렉션뷰셀
        collectionView.register(tabFirstCollectionViewCell.nib(), forCellWithReuseIdentifier: tabFirstCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //나의판매중상품조회:staus1
        getTest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //나의판매중상품조회:staus1
        getTest()
    }
    
    func UIsetting(){
        //검색창
//        searchBg.layer.borderColor = UIColor.systemGray4.cgColor
//        searchBg.layer.borderWidth = 1
        searchBg.layer.cornerRadius = 6
//        pointBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    func getTest() {
        
        guard let jwt = plist.string(forKey: "jwt") else{
               return
           }
        
        let url = "https://dev.wogus4048.shop/app/mypage/18"
//        let url = "https://dev.wogus4048.shop/app/mypage/18?status=1"
   
        //LCId=&MCId=&SCId=
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json",
                             "Accept":"application/json",
                             "X-ACCESS-TOKEN" : "eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyX2lkIjoxOCwiaWF0IjoxNjY0MTYyOTUwLCJleHAiOjE2NjU2MzQxNzl9.KvggLDCQVwpD8H9y9bFl_Wdzgyay52YZlBYYkc-sm-U"])
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
                    //                        print(dataJSON)
                    // JSON디코더 사용
                    self.newModel = try JSONDecoder().decode(NewModel.self, from: dataJSON)
                    debugPrint(res)
                    
                    print("내판매상품~~~~: \(self.newModel)")
                    OperationQueue.main.addOperation { // DispatchQueue도 가능.
                        self.collectionView.reloadData()
                    }
                 

                }// 디코딩 에러잡기
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


// MARK: - extension
extension myTabSellVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 상단컬렉션뷰 셀설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newModel?.result.count ?? 0
//        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tabFirstCollectionViewCell.identifier, for: indexPath) as! tabFirstCollectionViewCell
        
        // 이미지주소가
        let imgInfo = self.newModel?.result[indexPath.item].imgURL
                
                if imgInfo != nil {
                    // 킹피셔를 사용한 이미지 처리방법
                    if let imageURL = self.newModel?.result[indexPath.row].imgURL{
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
//        cell.imageView.image = UIImage(named: models[indexPath.item].imageName)
        cell.price.text = self.newModel?.result[indexPath.row].price?.description
        cell.title.text = self.newModel?.result[indexPath.row].title
        cell.place.text = "서울시 동작구"
        cell.uploadTime.text = "1시간전"
    
        return cell
    }
    
}
