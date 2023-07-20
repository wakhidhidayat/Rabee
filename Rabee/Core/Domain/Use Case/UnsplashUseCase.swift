//
//  UnsplashUseCase.swift
//  Rabee
//
//  Created by Wahid Hidayat on 20/07/23.
//

import Foundation

protocol UnsplashUseCase {
    func search(query: String, page: Int, completion: @escaping (Result<SearchModel, Error>) -> Void)
}

class UnsplashUseCaseImpl {
    private let repository: UnsplashRepository
    
    init(repository: UnsplashRepository) {
        self.repository = repository
    }
}

extension UnsplashUseCaseImpl: UnsplashUseCase {
    func search(query: String, page: Int, completion: @escaping (Result<SearchModel, Error>) -> Void) {
        repository.search(query: query, page: page) { result in
            completion(result)
        }
    }
}
