//
//  CategoryTableViewCell.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/24.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    static let identifier = "CategoryTableViewCell"
    
    static func nib()-> UINib{
            return UINib(nibName: "CategoryTableViewCell", bundle: nil)
        }

    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
