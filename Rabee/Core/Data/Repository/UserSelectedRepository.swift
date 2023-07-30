//
//  UserSelectedRepository.swift
//  Rabee
//
//  Created by Wahid Hidayat on 24/07/23.
//

import Foundation
import RxSwift

protocol UserSelectedRepository {
    func getUsersSelected() -> Observable<UserSelectedModel>
    func updateUserSelectedData(data: UserSelectedModel)
}

class UserSelectedRepositoryImpl {
    private let dataSource: UserSelectedDataSource
    
    private init(dataSource: UserSelectedDataSource) {
        self.dataSource = dataSource
    }
    
    static let shared: (UserSelectedDataSource) -> UserSelectedRepository = { dataSource in
        return UserSelectedRepositoryImpl(dataSource: dataSource)
    }
}

extension UserSelectedRepositoryImpl: UserSelectedRepository {
    func getUsersSelected() -> Observable<UserSelectedModel> {
        return dataSource.getUsersSelected()
    }
    
    func updateUserSelectedData(data: UserSelectedModel) {
        dataSource.updateUserSelectedData(data: data)
    }
}
