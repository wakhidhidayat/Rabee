//
//  SearchModel.swift
//  Rabee
//
//  Created by Wahid Hidayat on 20/07/23.
//

import Foundation

struct SearchModel {
    let totalPages: Int
    let results: [SearchResultModel]
}

struct SearchResultModel {
    let id: String
    let width: Int
    let height: Int
    let regularImageUrl: String?
    let thumbImageUrl: String?
}
