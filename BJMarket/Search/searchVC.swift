
//  searchVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/16.
//

import Foundation
import UIKit
import SnapKit
import Then

class searchVC :UIViewController{
    
    
    let tag: [String] = ["같이해요","동네질문","동네맛집","동네소식","취미생활","실시간동네날씨","분실/실종센터"]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: CollectionTableViewCell.className, bundle: nil), forCellReuseIdentifier: CollectionTableViewCell.cellId)
        
        tableView.register(UINib(nibName: Collection2TableViewCell.className, bundle: nil), forCellReuseIdentifier: Collection2TableViewCell.cellId)

    }
    
    //닫기
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension searchVC : UITableViewDelegate,
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
            //        cell.configure()
            
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
