//
//  Extention.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/22.
//

import UIKit

extension UIButton {
    //밑줄
    func setUnderline() {
        guard let title = title(for: .normal) else {return}
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: title.count))
        setAttributedTitle(attributedString, for: .normal)
    }
    
//
    func optionSelected() {
        self.backgroundColor = UIColor(red: 255/255, green: 238/255, blue: 240/255, alpha: 1.0)
//        self.backgroundColor = UIColor.systemRed
        self.setTitleColor(.red, for: .normal)
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 6
//        self.layer.borderColor = UIColor.white.cgColor
    }

    func optionDeselected() {
        self.backgroundColor = .white
        self.setTitleColor(.lightGray, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 228/255, green: 227/255, blue: 228/255, alpha: 1.0).cgColor
        self.layer.cornerRadius = 6
    }

  
    func notFollow() {
        self.setTitle("팔로우", for: .normal)
        self.setTitleColor(.systemRed, for: .normal)
        self.backgroundColor = UIColor(red: 254/255, green: 238/255, blue: 239/255, alpha: 1.0)
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func followed() {
        self.setTitle("팔로잉", for: .normal)
        self.setTitleColor(.darkGray, for: .normal)
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray6.cgColor
    }
  
}
