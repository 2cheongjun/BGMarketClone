//
//  NetworkResult.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/22.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
