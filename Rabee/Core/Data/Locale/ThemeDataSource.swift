//
//  ThemeDataSource.swift
//  Rabee
//
//  Created by Wahid Hidayat on 24/07/23.
//

import Foundation
import RxSwift

protocol ThemeDataSource {
    func getThemes() -> Observable<[Theme]>
    func selectTheme(id: Int, completion: () -> Void)
}

class ThemeDataSourceImpl {
    private init() {}
    
    static let shared: ThemeDataSource = ThemeDataSourceImpl()
    
    private var themes = [
        Theme(id: 1, name: "Rustic", image: "rustic"),
        Theme(id: 2, name: "Minimalist", image: "minimalist"),
    ]
}

extension ThemeDataSourceImpl: ThemeDataSource {
    func getThemes() -> Observable<[Theme]> {
        return Observable.create { observer in
            observer.onNext(self.themes)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func selectTheme(id: Int, completion: () -> Void) {
        guard let userId = UserDefaultsHelper.shared.getId() else { return }
        
        // remove previous selected theme from current user
        for themeIndex in 0..<themes.count {
            for userIdIndex in 0..<themes[themeIndex].usersId.count {
                if themes[themeIndex].usersId[userIdIndex] == userId {
                    themes[themeIndex].usersId.remove(at: userIdIndex)
                }
            }
        }
        
        // select theme
        for themeIndex in 0..<themes.count {
            if themes[themeIndex].id == id {
                themes[themeIndex].usersId.append(userId)
            }
        }
        
        completion()
    }
}
