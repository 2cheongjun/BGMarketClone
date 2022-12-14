//
//  sCollectionViewCell.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/24.
//

import UIKit

class sCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "sCollectionViewCell"
    static let className = "sCollectionViewCell"

    @IBOutlet weak var bgBtn: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgBtn.layer.cornerRadius = 20
    }

}
