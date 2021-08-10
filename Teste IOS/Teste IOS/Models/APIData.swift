//
//  APIData.swift
//  Teste IOS
//
//  Created by Paulo Danilo Conceição Lima on 08/08/21.
//

import Foundation

struct APIData: Codable {
    let notifications : [notifications]
}

struct notifications: Codable{
    let id: String
    let isRead: Bool
    let content: String
}
