//
//  ProductModel.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/23.
//

import Foundation

// MARK: - ProductModel
struct ProductModel: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: ProductResult?
}

// MARK: - Result
struct ProductResult: Codable {
    let postID: Int?
    let imgUrls: [String]?
    let title, region, createdAt: String?
    let categoryLarge, categoryMiddle, categorySmall: Int?
    let tags: [String]?
    let price: Int?
    let content: String?
    let count, isExchangable, safepay, deliveryFee: Int?
    let pcondition: Int?

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case imgUrls, title, region
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

