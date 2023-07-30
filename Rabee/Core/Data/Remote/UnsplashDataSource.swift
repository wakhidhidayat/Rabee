//
//  UnsplashDataSource.swift
//  Rabee
//
//  Created by Wahid Hidayat on 19/07/23.
//

import Foundation
import Alamofire

protocol UnsplashDataSource {
    func search(query: String, color: ColorFilter?, page: Int, orientation: Orientation, completion: @escaping (Result<SearchResponse, Error>) -> Void)
}

class UnsplashDataSourceImpl {
    private init() {}
    
    static let shared: UnsplashDataSource = UnsplashDataSourceImpl()
}

extension UnsplashDataSourceImpl: UnsplashDataSource {
    func search(query: String, color: ColorFilter?, page: Int, orientation: Orientation, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        AF.request(
            Endpoints.search.url.replacingOccurrences(of: " ", with: "%20"),
            parameters: API.searchParameters(query: query, color: color, orientation: orientation, page: page)
        )
        .validate()
        .responseDecodable(of: SearchResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
