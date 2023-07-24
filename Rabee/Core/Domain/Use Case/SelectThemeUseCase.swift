//
//  SelectThemeUseCase.swift
//  Rabee
//
//  Created by Wahid Hidayat on 24/07/23.
//

import Foundation
import RxSwift

protocol SelectThemeUseCase {
    func getThemes() -> Observable<[Theme]>
    func selectTheme(id: Int, completion: () -> Void)
}

class SelectThemeUseCaseImpl {
    private let repo: ThemeRepository
    
    init(repo: ThemeRepository) {
        self.repo = repo
    }
}

extension SelectThemeUseCaseImpl: SelectThemeUseCase {
    func getThemes() -> Observable<[Theme]> {
        return repo.getThemes()
    }
    
    func selectTheme(id: Int, completion: () -> Void) {
        repo.selectTheme(id: id, completion: completion)
    }
}
