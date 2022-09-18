//
//  My2CollectionViewCell.swift
//  CollectionViewinTableView
//
//  Created by jh on 2022/01/03.
//

import UIKit

class My2CollectionViewCell: UICollectionViewCell {

    static let cellId = "My2CollectionViewCell"
    static let className = "My2CollectionViewCell"
    @IBOutlet weak var btn: UIButton!
    
    @IBOutlet var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor =  UIColor.systemGray5.cgColor
    }
    public func configure() {
        titleLbl.text = "최근검색어"
//        imageView.tintColor = .blue
    }

}
