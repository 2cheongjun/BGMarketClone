//
//  reviewCell.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/20.
//

import UIKit

class reviewCell: UITableViewCell {
    
    static let identifier = "reviewCell"
    
    static func nib()-> UINib{
         return UINib(nibName: "reviewCell", bundle: nil)
     }

    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var when: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
