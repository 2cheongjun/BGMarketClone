//
//  SCModel.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/24.
//

import Foundation

// MARK: - SCModel
struct SCModel: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [SCResult]?
}

// MARK: - Result
struct SCResult: Codable {
    let largeCategoryID: Int?
    let largeCategoryName: String?
    let middleCategoryID: Int?
    let middleCategoryName: String?
    let smallCategoryID: Int?
    let smallCategoryName: String?

    enum CodingKeys: String, CodingKey {
        case largeCategoryID = "large_category_id"
        case largeCategoryName = "large_category_name"
        case middleCategoryID = "middle_category_id"
        case middleCategoryName = "middle_category_name"
        case smallCategoryID = "small_category_id"
        case smallCategoryName = "small_category_name"
    }
}
