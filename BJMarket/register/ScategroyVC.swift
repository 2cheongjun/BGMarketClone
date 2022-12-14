//
//  ScategroyVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/24.
//

import Foundation
import UIKit
import Alamofire

class ScategoryVC :UIViewController{
    
    var scModel :SCModel?
    var result: SCResult?
    let plist = UserDefaults.standard

    @IBOutlet weak var stableView: UITableView!
    
    override func viewDidLoad() {
        stableView.delegate = self
        stableView.dataSource = self
        let nibName = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        stableView.register(nibName, forCellReuseIdentifier:"CategoryTableViewCell")
        
        postCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        postCategory()
    }
    
    
    @IBAction func close(_ sender: Any) {
       
        self.dismiss(animated: true, completion: nil)//뷰컨닫기
    }
    
    func postCategory() {
        let url = "https://dev.wogus4048.shop/app/post/category-small?MCId=6"
        //LCId=&MCId=&SCId=
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
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
                    self.scModel = try JSONDecoder().decode(SCModel.self, from: dataJSON)
                    
                    OperationQueue.main.addOperation { // DispatchQueue도 가능.
                        self.stableView.reloadData()
                    }
                   
                    
                    print("대분류카테고리 : \(self.scModel)")
                    
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
    
    
}//end


extension ScategoryVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scModel?.result?.count ?? 0
//         return 25
    }
    
    // 셀 높이 컨텐츠에 맞게 자동으로 설정// 컨텐츠의 내용높이 만큼이다.
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        print("Scategory닫기")
        plist.setValue("여성의류 > 패딩점퍼 > 롱패딩", forKey: "category")//이름이라는 키로 저장
        plist.synchronize()//동기화처리
        
        // 선택한것 눌렸다가 자연스럽게 흰색으로 전환
        tableView.deselectRow(at: indexPath, animated: true)
        
        //스택에 쌓인 뷰컨 닫기?(밑에 깔려있는뷰 닫기)
//        self.dismiss(animated: true, completion: nil)//뷰컨닫기
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        
        //cell.imageView.image = UIImage(named: "01")
        //          cell.mImgView.image =  UIImage(named: "01")
        //          cell.mImgView.image = UIImage(named: models[indexPath.item].imageName)
        cell.label.text =  self.scModel?.result?[indexPath.row].smallCategoryName
        
        return cell
    }
}
