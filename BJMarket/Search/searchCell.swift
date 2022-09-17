//
//  CollectionViewCell.swift
//  PracticeAutolayout
//
//  Created by 이청준 on 2022/08/17.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btn: UIButton!
    
    static let identifier = "CollectionViewCell"
    
    @IBOutlet weak var label: UILabel!

    
    static func nib()-> UINib{
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    


}


