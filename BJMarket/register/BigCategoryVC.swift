//
//  CategoryVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/24.
//
import Foundation
import UIKit
import Alamofire

//카테고리 대분류
class BigCategoryVC: UIViewController {
    
    var bcModel : BCModel?
    var result: BCResult?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier:"CategoryTableViewCell")
        
        postCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        postCategory()
    }
    
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)//뷰컨닫기
    }
    
    func postCategory() {
        let url = "https://dev.wogus4048.shop/app/post/category-large"
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
                    self.bcModel = try JSONDecoder().decode(BCModel.self, from: dataJSON)
                    
                    OperationQueue.main.addOperation { // DispatchQueue도 가능.
                        self.tableView.reloadData()
                    }
                   
                    
                    print("대분류카테고리 : \(self.bcModel)")
                    
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


extension BigCategoryVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bcModel?.result.count ?? 0
//         return 25
    }
    
    // 셀 높이 컨텐츠에 맞게 자동으로 설정// 컨텐츠의 내용높이 만큼이다.
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        // 선택한것 눌렸다가 자연스럽게 흰색으로 전환
        tableView.deselectRow(at: indexPath, animated: true)
        
        //네비푸시이동
        guard let nextVC =  self.storyboard?.instantiateViewController(withIdentifier: "McategoryVC")  else {return}
            
        self.navigationController?.pushViewController(nextVC, animated: true)
    

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        
        //cell.imageView.image = UIImage(named: "01")
        //          cell.mImgView.image =  UIImage(named: "01")
        //          cell.mImgView.image = UIImage(named: models[indexPath.item].imageName)
        cell.label.text =  self.bcModel?.result[indexPath.row].largeCategoryName
        
        return cell
    }
}
