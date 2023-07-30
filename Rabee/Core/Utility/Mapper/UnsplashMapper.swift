//
//  UnsplashMapper.swift
//  Rabee
//
//  Created by Wahid Hidayat on 20/07/23.
//

import Foundation

struct UnsplashMapper {
    static func mapSearchResponseToModel(from response: SearchResponse) -> SearchModel {
        var results = [SearchResultModel]()
        
        for data in response.results {
            results.append(SearchResultModel(id: data.id ?? "", width: data.width ?? 0, height: data.height ?? 0, regularImageUrl: data.urls?.regular, thumbImageUrl: data.urls?.thumb))
        }
        
        return SearchModel(totalPages: response.totalPages ?? 1, results: results)
    }
}
