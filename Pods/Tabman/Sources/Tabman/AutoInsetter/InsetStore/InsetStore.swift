//
//  InsetStore.swift
//  AutoInsetter
//
//  Created by Merrick Sapsford on 19/03/2019.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

protocol InsetStore: AnyObject {
    
    func store(contentInset: UIEdgeInsets, for view: UIScrollView)
    func store(contentOffset: CGPoint, for view: UIScrollView)
    
    func contentInset(for view: UIScrollView) -> UIEdgeInsets?
    func contentOffset(for view: UIScrollView) -> CGPoint?
}
