//
//  UnsplashDataSource.swift
//  Rabee
//
//  Created by Wahid Hidayat on 19/07/23.
//

import Foundation
import Alamofire

protocol UnsplashDataSource {
    func search(query: String, page: Int, completion: @escaping (Result<SearchResponse, Error>) -> Void)
}

class UnsplashDataSourceImpl {
    private init() {}
    
    static let shared: UnsplashDataSource = UnsplashDataSourceImpl()
}

extension UnsplashDataSourceImpl: UnsplashDataSource {
    func search(query: String, page: Int, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        let urlString = Endpoints.Gets.search(query: query, page: page).url.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: urlString) else { return }
        AF.request(url)
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
