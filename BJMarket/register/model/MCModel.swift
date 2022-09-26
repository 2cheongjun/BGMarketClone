//
//  MCModel.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/24.
//

import Foundation

// MARK: - MCModel
struct MCModel: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [MCResult]?
}

// MARK: - Result
struct MCResult: Codable {
    let largeCategoryID: Int?
    let largeCategoryName: String?
    let middleCategoryID: Int?
    let middleCategoryName: String?

    enum CodingKeys: String, CodingKey {
        case largeCategoryID = "large_category_id"
        case largeCategoryName = "large_category_name"
        case middleCategoryID = "middle_category_id"
        case middleCategoryName = "middle_category_name"
    }
}
