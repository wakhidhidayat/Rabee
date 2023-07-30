//
//  UnsplashInjection.swift
//  Rabee
//
//  Created by Wahid Hidayat on 20/07/23.
//

import Foundation

class UnsplashInjection {
    private func getRepo() -> UnsplashRepository {
        let dataSource = UnsplashDataSourceImpl.shared
        return UnsplashRepositoryImpl.shared(dataSource)
    }
    
    func getUseCase() -> UnsplashUseCase {
        let repo = getRepo()
        return UnsplashUseCaseImpl(repository: repo)
    }
}
