//
//  iconTab1VC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/15.
//

import Foundation
import UIKit

class iconTab1VC: UIViewController{
    
    //이미지뷰클릭해이동
    @IBOutlet weak var legoImg: UIImageView!
    
    
    override func viewDidLoad() {
        let imgBtn = UITapGestureRecognizer(target: self, action: #selector(imgClick))
        legoImg.isUserInteractionEnabled = true
        legoImg.addGestureRecognizer(imgBtn)
    }
 
    
    @objc func imgClick(sender: UITapGestureRecognizer) {
            print("클릭!!!!!")
        
        guard let CategoryVC = self.storyboard?.instantiateViewController(identifier: "legoVC") as? CategoryVC else { return }

        self.present(CategoryVC, animated: true, completion: nil)

        }

    
}
