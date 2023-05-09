//
//  Token.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 09.05.2023.
//

struct ResponseToken: Codable {
    var success: Bool
    var expiresAt, requestToken: Int

    enum CodingKeys: String, CodingKey {
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
