//
//  CollectionViewCell.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/14.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    static let identifier = "CollectionViewCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    static func nib()-> UINib{
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
    

}
