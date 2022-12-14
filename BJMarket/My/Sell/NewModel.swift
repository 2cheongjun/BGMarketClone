//
//  MyModel.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/26.
//

import Foundation

// MARK: - NewModel
struct NewModel: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [NewResult]
}

// MARK: - Result
struct NewResult: Codable {
    let postID, price: Int?
    let title, content: String?
    let safepay: Int?
    let imgURL: String?

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case price, title, content, safepay
        case imgURL = "imgUrl"
    }
}
