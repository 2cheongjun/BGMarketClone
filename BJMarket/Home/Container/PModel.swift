//
//  ProductModel.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/22.
//


import Foundation

// MARK: - PModel
struct PModel: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: [PResult]
}

// MARK: - Result
struct PResult: Codable {
    let postID: Int?
    let imgURL: String?
    let price: Int?
    let title: String?
    let safepay: Int?
    let region: Region?
    let createdAt: CreatedAt?
    let jjim: Int?

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case imgURL = "imgUrl"
        case price, title, safepay, region
        case createdAt = "created_at"
        case jjim
    }
}

enum CreatedAt: String, Codable {
    case the10일전 = "10일 전"
    case the1일전 = "1일 전"
    case the2일전 = "2일 전"
    case the3일전 = "3일 전"
    case the4일전 = "4일 전"
    case the5일전 = "5일 전"
    case the6일전 = "6일 전"
    case the7일전 = "7일 전"
    case the9일전 = "9일 전"
    case the11일전 = "11일 전"
    case the0시간전 = "0시간 전"
    case the1시간전 = "1시간 전"
}

enum Region: String, Codable {
    case 관악 = "관악"
    case 동작 = "동작"
    case 동작구 = "동작구"
    case 서울관악구 = "서울 관악구"
    case 서울시관악구 = "서울시 관악구"
    case 서울중랑구 = "서울 중랑구"
    case 지역정보없음 = "지역정보 없음"
}
