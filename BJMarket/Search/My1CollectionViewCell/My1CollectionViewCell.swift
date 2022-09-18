//
//  MyCollectionViewCell.swift
//  CollectionViewinTableView
//
//  Created by jh on 2022/01/02.
//

import UIKit

class My1CollectionViewCell: UICollectionViewCell {

    static let cellId = "My1CollectionViewCell"
    static let className = "My1CollectionViewCell"
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        layer.shadowColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor =  UIColor.systemGray5.cgColor
    }
    
    
    // data model 넣으면 됨
    public func configure() {
        myLabel.text = "캠핑용품"
//        myImageView.tintColor = .blue
    }

}
