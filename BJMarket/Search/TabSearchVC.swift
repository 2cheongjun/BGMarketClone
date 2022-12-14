//
//  TabSearchVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/20.
//

import Foundation
import UIKit

class TabSearchVC: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFiled: UITextField!
    
    var word = ""
    var searchModel:SearchModel?
    
    //닫기
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        textFiled.delegate = self

        tableView.register(UINib(nibName: CollectionTableViewCell.className, bundle: nil), forCellReuseIdentifier: CollectionTableViewCell.cellId)
        tableView.register(UINib(nibName: Collection2TableViewCell.className, bundle: nil), forCellReuseIdentifier: Collection2TableViewCell.cellId)
        

    }
    
    //키보드 리턴버튼 누르기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textFiled == self.textFiled{

            //검색호출
            // MARK: -검색창작성내용
            print("word")
            
            //화면이동
            if let nextScene = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultVC" ){
                nextScene.modalPresentationStyle = .fullScreen
                // 화면 전환 애니메이션의 타입
                self.present(nextScene, animated : true)
            }
        }
        return true
    }
    
    
  
    
  
}

extension TabSearchVC : UITableViewDelegate,
                          UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.cellId, for: indexPath) as! CollectionTableViewCell
            cell.configure()

            return cell
        case 1:
            let cell =
            tableView.dequeueReusableCell(withIdentifier: Collection2TableViewCell.cellId, for: indexPath) as! Collection2TableViewCell
            // 최근검색어 가져와 뿌리기
//             cell.configure()
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
    CGFloat {
        let interval:CGFloat = 3
        let width: CGFloat = (UIScreen.main.bounds.width - interval * 3)/2
        
        switch indexPath.row{
        case 0:
            return 250
        case 1:
            return (width + 40 + 3) * 5 + 40
        default:
            return 0
        }
    }
}
