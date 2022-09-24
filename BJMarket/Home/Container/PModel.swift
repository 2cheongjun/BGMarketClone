//
//  ProductModel.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/22.
//

import Foundation

// MARK: - Welcome
struct PModel: Codable {
    let result: [PResult]
}

struct PResult: Codable {
    let postID, price: Int?
    let title: String?
    let safepay: Int?
    let imgURL: String?
    
    enum CodingKeys: String,CodingKey {
        case postID = "post_id"
        case price, title, safepay
        case imgURL = "imgUrl"
    }
}
