//
//  CollectionViewCell.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/14.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bg: UIView!
    
    static let identifier = "CollectionViewCell"
    
    static func nib()-> UINib{
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bg.layer.cornerRadius = 6
    }



}
