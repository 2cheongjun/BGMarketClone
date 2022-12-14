//
//  RegisterDetailModel.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/27.
//

import Foundation

// MARK: - ResiterDetailModel
struct ResiterDetailModel: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: ResiterDetailModelResult?
}

// MARK: - Result
struct ResiterDetailModelResult: Codable {
    let postID: Int?
    let imgUrls: [String]?
    let userID: Int?
    let title, region, createdAt: String?
    let categoryLarge, categoryMiddle, categorySmall: Int?
    let tags: [String]?
    let price: Int?
    let content: String?
    let count, isExchangable, safepay, deliveryFee: Int?
    let pcondition: Int?

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case imgUrls
        case userID = "user_id"
        case title, region
        case createdAt = "created_at"
        case categoryLarge = "category_large"
        case categoryMiddle = "category_middle"
        case categorySmall = "category_small"
        case tags, price, content, count
        case isExchangable = "is_exchangable"
        case safepay
        case deliveryFee = "delivery_fee"
        case pcondition
    }
}
