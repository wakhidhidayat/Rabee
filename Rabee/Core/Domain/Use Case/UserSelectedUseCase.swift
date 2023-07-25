//
//  UserSelectedUseCase.swift
//  Rabee
//
//  Created by Wahid Hidayat on 24/07/23.
//

import Foundation
import RxSwift

protocol UserSelectedUseCase {
    func getUsersSelected() -> Observable<UserSelectedModel>
    func updateUserSelectedData(data: UserSelectedModel)
}

class UserSelectedUseCaseImpl {
    private let repo: UserSelectedRepository
    
    init(repo: UserSelectedRepository) {
        self.repo = repo
    }
}

extension UserSelectedUseCaseImpl: UserSelectedUseCase {
    func getUsersSelected() -> Observable<UserSelectedModel> {
        repo.getUsersSelected()
    }
    
    func updateUserSelectedData(data: UserSelectedModel) {
        repo.updateUserSelectedData(data: data)
    }
}
