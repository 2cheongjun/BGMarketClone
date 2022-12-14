//
//  tabFirstCollectionViewCell.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/15.
//

import UIKit

class tabFirstCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "tabFirstCollectionViewCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var uploadTime: UILabel!
    @IBOutlet weak var heartCount: UILabel!
    
    //하트버튼
    @IBOutlet weak var btnHeart: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // 셀세팅
        setupLayout()
    }
    
    static func nib()-> UINib{
        return UINib(nibName: "tabFirstCollectionViewCell", bundle: nil)
    }
    
    func setupLayout() {
        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowRadius = 10
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
    }

}
