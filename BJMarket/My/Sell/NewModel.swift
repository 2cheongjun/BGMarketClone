//
//  MyModel.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/26.
//

import Foundation

// MARK: - MyModel
struct MyModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [MYResult]
}

// MARK: - Result
struct MYResult: Codable {
    let postID: Int?
    let price: Int?
    let title, content: String?
    let safepay: Int?
    let imgURL: String?
    
    enum CodingKeys: String,CodingKey {
        case postID = "post_id"
        case price,title,content,safepay
        case imgURL = "imgUrl"
    }
}

