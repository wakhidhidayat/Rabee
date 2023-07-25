//
//  UserSelectedInjection.swift
//  Rabee
//
//  Created by Wahid Hidayat on 24/07/23.
//

import Foundation

class UserSelectedInjection {
    private func getRepo() -> UserSelectedRepository {
        let dataSource = UserSelectedDataSourceImpl.shared
        return UserSelectedRepositoryImpl.shared(dataSource)
    }
    
    func getUseCase() -> UserSelectedUseCase {
        let repo = getRepo()
        return UserSelectedUseCaseImpl(repo: repo)
    }
}
