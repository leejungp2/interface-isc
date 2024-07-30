//
//  APIResponse.swift
//  PhotoSearch
//
//  Created by 쩡이 on 2021/12/14.
//

import Foundation

struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let regular: String
}
