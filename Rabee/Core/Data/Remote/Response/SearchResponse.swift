//
//  SearchResponse.swift
//  Rabee
//
//  Created by Wahid Hidayat on 19/07/23.
//

import Foundation

enum ColorFilter: String, CaseIterable, Codable {
    case blackAndWhite = "black_and_white"
    case black
    case white
    case yellow
    case orange
    case red
    case purple
    case magenta
    case green
    case teal
    case blue
}

enum Orientation: String {
    case landscape
    case portrait
    case squarish
}

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
