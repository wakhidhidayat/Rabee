//
//  ThemeRepository.swift
//  Rabee
//
//  Created by Wahid Hidayat on 24/07/23.
//

import Foundation
import RxSwift

protocol ThemeRepository {
    func getThemes() -> Observable<[Theme]>
    func selectTheme(id: Int, completion: () -> Void)
}

class ThemeRepositoryImpl {
    private let dataSource: ThemeDataSource
    
    private init(dataSource: ThemeDataSource) {
        self.dataSource = dataSource
    }
    
    static let shared: (ThemeDataSource) -> ThemeRepository = { dataSource in
        return ThemeRepositoryImpl(dataSource: dataSource)
    }
}

extension ThemeRepositoryImpl: ThemeRepository {
    func getThemes() -> Observable<[Theme]> {
        return dataSource.getThemes()
    }
    
    func selectTheme(id: Int, completion: () -> Void) {
        return dataSource.selectTheme(id: id, completion: completion)
    }
}
