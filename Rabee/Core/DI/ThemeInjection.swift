//
//  ThemeInjection.swift
//  Rabee
//
//  Created by Wahid Hidayat on 24/07/23.
//

import Foundation

class ThemeInjection {
    private func getRepo() -> ThemeRepository {
        let dataSource = ThemeDataSourceImpl.shared
        return ThemeRepositoryImpl.shared(dataSource)
    }
    
    func getUseCase() -> SelectThemeUseCase {
        let repo = getRepo()
        return SelectThemeUseCaseImpl(repo: repo)
    }
}
