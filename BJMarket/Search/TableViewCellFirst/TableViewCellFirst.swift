//
//  TableViewCellFirst.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/24.
//

import UIKit

class TableViewCellFirst: UITableViewCell {
    
    let padingWord :[String] = ["숏패딩","몽클레어패딩","나이키패딩","여자패딩","남자패딩","경량패딩","숏패딩","노스페이스패딩","나이키패딩","아이더패딩","나이키패딩"]
    
    //클래스명, 테이블뷰셀1 이름
    static let cellId = "TableViewCellFirst"
    static let className = "TableViewCellFirst"
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    func configure(){
        collectionView.reloadData()
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: sCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier : sCollectionViewCell.cellId)
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}



extension TableViewCellFirst: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.padingWord.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sCollectionViewCell.cellId, for: indexPath) as! sCollectionViewCell
        
        cell.label.text = self.padingWord[indexPath.row]
//        print(padingWord)
//        cell.configure()
        //cell.configure(with: model[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
