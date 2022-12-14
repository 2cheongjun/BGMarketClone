//
//  TableViewCellSecond.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/24.
//

import UIKit
import MaterialComponents.MaterialBottomSheet
import Foundation

class TableViewCellSecond: UITableViewCell {
    
    let word :[String] = ["브랜드","카테고리","동네","가격","혜택","검수","판매완료제외"]
    
    @IBOutlet var collectionView: UICollectionView!
    
    static let cellId = "TableViewCellSecond"
    static let className = "TableViewCellSecond"

    @IBOutlet weak var filterBTn: UIButton!
    
    
    //API호출
    @IBAction func fillterAction(_ sender: Any) {
        print("화살표!!!!")
      
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(UINib(nibName: s2CollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier : s2CollectionViewCell.cellId)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension TableViewCellSecond: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return word.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: s2CollectionViewCell.cellId, for: indexPath) as! s2CollectionViewCell
            cell.label.text = word[indexPath.row]
        
        //        cell.configure(with: model[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interval:CGFloat = 3
        let width: CGFloat = ( UIScreen.main.bounds.width - interval * 3 ) / 2
        return CGSize(width: width , height: width + 40)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
