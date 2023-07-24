//
//  SelectThemeViewModel.swift
//  Rabee
//
//  Created by Wahid Hidayat on 24/07/23.
//

import Foundation
import RxSwift

class SelectThemeViewModel {
    private let useCase = ThemeInjection().getUseCase()
    private let disposeBag = DisposeBag()
    
    let themes: BehaviorSubject<[Theme]> = .init(value: [])
    
    func getThemes() {
        useCase.getThemes()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] themes in
                self?.themes.onNext(themes)
            }
            .disposed(by: disposeBag)
    }
    
    func setTheme(id: Int, completion: () -> Void) {
        useCase.selectTheme(id: id, completion: completion)
    }
}
