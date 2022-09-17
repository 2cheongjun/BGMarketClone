//
//  myTabSellVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/16.
//

import UIKit

class myTabSellVC : UIViewController{
    
    
    @IBOutlet weak var fillterBtn: UIImageView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchBg: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    
    override func viewDidLoad() {
        UIsetting()
        
        //컬렉션뷰셀
        collectionView.register(myTabSellVCCell.nib(), forCellWithReuseIdentifier: myTabSellVCCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func UIsetting(){
        //포인트버튼
        searchBg.layer.borderColor = UIColor.systemGray4.cgColor
        searchBg.layer.borderWidth = 1
        searchBg.layer.cornerRadius = 6
//        pointBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
}
