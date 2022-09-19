//
//  productCell.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/19.
//

import UIKit

class productCell: UICollectionViewCell {
    
    static let identifier = "productCell"
    
    @IBOutlet weak var mImgView: UIImageView!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var pdTitle: UILabel!
    
    static func nib()-> UINib{
        return UINib(nibName: "productCell", bundle: nil)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLayout()
    }

    // 이미지만 라운드값 주기 어떻게????
    func setupLayout() {
        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowRadius = 10
        mImgView?.layer.cornerRadius = 6
        mImgView?.layer.masksToBounds = true
    }

}
