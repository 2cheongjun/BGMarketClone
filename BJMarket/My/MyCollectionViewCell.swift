//
//  MyCollectionViewCell.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/16.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    

    static let identifier = "MyCollectionViewCell"
    
    static func nib()-> UINib{
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLayout()
    }
    
    func setupLayout() {
        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowRadius = 10
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
    }

}
