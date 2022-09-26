//
//  BCategoryModel.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/24.
//


import Foundation

// MARK: - BCategoryModel
struct BCModel: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [BCResult]
}

// MARK: - Result
struct BCResult: Codable {
    let largeCategoryID: Int?
    let largeCategoryName: String?

    enum CodingKeys: String, CodingKey {
        case largeCategoryID = "large_category_id"
        case largeCategoryName = "large_category_name"
    }
}

