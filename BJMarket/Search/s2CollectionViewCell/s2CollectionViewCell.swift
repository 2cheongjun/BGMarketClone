//
//  s2CollectionViewCell.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/24.
//

import UIKit

class s2CollectionViewCell: UICollectionViewCell {
    
    static let cellId = "s2CollectionViewCell"
    static let className = "s2CollectionViewCell"

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor =  UIColor.systemGray5.cgColor
    }

}
