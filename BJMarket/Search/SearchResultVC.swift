//
//  SearchResultVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/24.
//

import Foundation
import UIKit

class SearchResultVC : UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: TableViewCellFirst.className, bundle: nil), forCellReuseIdentifier: TableViewCellFirst.cellId)
        
        tableView.register(UINib(nibName: Collection2TableViewCell.className, bundle: nil), forCellReuseIdentifier: Collection2TableViewCell.cellId)
        
        //검색창에 입력한내용(최근검색어내용저장해서 word모델에 담기)-> CollectionTableViewCell에서 넣기
        let text = textField.text
        print(text!)

    }
    
    //닫기
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}



extension SearchResultVC : UITableViewDelegate,
                          UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellFirst.cellId, for: indexPath) as! TableViewCellFirst
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
