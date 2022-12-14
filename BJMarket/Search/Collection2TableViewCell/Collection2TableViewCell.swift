//
//  Collection2TableViewCell.swift
//  CollectionViewinTableView
//
//  Created by jh on 2022/01/03.
//

import UIKit

class Collection2TableViewCell: UITableViewCell {
    
    let word :[String] = ["01 짱구키링","02 아미 가디건","03 버거킹","04 투티에","05 샤이니","06 도미노","07 pdf","08 국대","09 슈퍼주니어","10 cu"]

    @IBOutlet var collectionView: UICollectionView!
    
    static let cellId = "Collection2TableViewCell"
    static let className = "Collection2TableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(UINib(nibName: My2CollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier : My2CollectionViewCell.cellId)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension Collection2TableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return word.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: My2CollectionViewCell.cellId, for: indexPath) as! My2CollectionViewCell
            cell.titleLbl.text = word[indexPath.row]
        
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


