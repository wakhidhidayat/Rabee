//
//  UnsplashRepository.swift
//  Rabee
//
//  Created by Wahid Hidayat on 19/07/23.
//

import Foundation

protocol UnsplashRepository {
    func search(query: String, color: ColorFilter?, page: Int, orientation: Orientation, completion: @escaping (Result<SearchModel, Error>) -> Void)
}

class UnsplashRepositoryImpl: NSObject {
    private let remoteDataSource: UnsplashDataSource
    
    private init(remoteDataSource: UnsplashDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    static let shared: (UnsplashDataSource) -> UnsplashRepository = { remoteRepo in
        return UnsplashRepositoryImpl(remoteDataSource: remoteRepo)
    }
}

extension UnsplashRepositoryImpl: UnsplashRepository {
    func search(query: String, color: ColorFilter?, page: Int, orientation: Orientation, completion: @escaping (Result<SearchModel, Error>) -> Void) {
        remoteDataSource.search(query: query, color: color, page: page, orientation: orientation) { remoteResponse in
            switch remoteResponse {
            case .success(let searchResponse):
                let modelData = UnsplashMapper.mapSearchResponseToModel(from: searchResponse)
                completion(.success(modelData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
