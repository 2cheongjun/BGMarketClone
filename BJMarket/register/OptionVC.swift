//
//  OptionVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/21.
//

import Foundation
import UIKit

class OptionVC: UIViewController {
    
    @IBOutlet weak var input: UITextField!
    
    @IBOutlet weak var oldBtn: UIButton!
    @IBOutlet weak var newBtn: UIButton!
    
    @IBOutlet weak var NoBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func tapOldButton(_ sender: UIButton) {
//          self.isOldText = "중고상품"
            self.oldBtn.optionSelected()
            self.newBtn.optionDeselected()
            //          oldBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            oldBtn.tintColor = UIColor.systemRed
            newBtn.tintColor = UIColor.systemGray2
          }
      
      @IBAction func tapNewButton(_ sender: UIButton) {
//          self.isOldText = "새상품"
          self.newBtn.optionSelected()
          self.oldBtn.optionDeselected()
          newBtn.tintColor = UIColor.systemRed
          oldBtn.tintColor = UIColor.systemGray2
      }
    
    @IBAction func NoBtn(_ sender: Any) {
        self.NoBtn.optionSelected()
        self.yesBtn.optionDeselected()
        NoBtn.tintColor = UIColor.systemRed
        yesBtn.tintColor = UIColor.systemGray2
    }
    
    @IBAction func yesBtn(_ sender: Any) {
        self.yesBtn.optionSelected()
        self.NoBtn.optionDeselected()
        yesBtn.tintColor = UIColor.systemRed
        NoBtn.tintColor = UIColor.systemGray2
    }

}


