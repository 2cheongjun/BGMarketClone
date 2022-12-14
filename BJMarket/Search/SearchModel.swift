//
//  SearchModel.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/25.
//

import Foundation

// MARK: - SearchModel
struct SearchModel: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [SearchResult]?
}

// MARK: - Result
struct SearchResult: Codable {
    let postID: Int?
    let images: String?
    let title: String?
    let price: Int?

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case images, title, price
    }
}

