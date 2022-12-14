//
//  LoginModel.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/23.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: LoginResult?
}

// MARK: - Result
struct LoginResult: Codable {
    let userID: Int?
    let kakaoID, jwt: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case kakaoID = "kakao_id"
        case jwt
    }
}
