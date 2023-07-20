//
//  SearchResponse.swift
//  Rabee
//
//  Created by Wahid Hidayat on 19/07/23.
//

import Foundation

struct SearchResponse: Decodable {
    let totalPages: Int?
    let results: [SearchResult]
    
    private enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case results
    }
}

struct SearchResult: Decodable {
    let id: String?
    let width: Int?
    let height: Int?
    let urls: ImageUrl?
}

struct ImageUrl: Decodable {
    let regular: String?
    let thumb: String?
}
