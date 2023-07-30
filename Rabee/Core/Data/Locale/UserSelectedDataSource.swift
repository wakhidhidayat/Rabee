//
//  UserSelectedDataSource.swift
//  Rabee
//
//  Created by Wahid Hidayat on 24/07/23.
//

import Foundation
import RxSwift

protocol UserSelectedDataSource {
    func getUsersSelected() -> Observable<UserSelectedModel>
    func updateUserSelectedData(data: UserSelectedModel)
}

class UserSelectedDataSourceImpl {
    private init() {}
    
    static let shared: UserSelectedDataSource = UserSelectedDataSourceImpl()
    
    private var usersSelected = UserSelectedModel(
        themes: [
            Theme(id: 1, name: "Rustic", image: "Rustic"),
            Theme(id: 2, name: "Modern", image: "Modern"),
            Theme(id: 3, name: "Vintage", image: "Vintage"),
            Theme(id: 4, name: "Beach", image: "Beach"),
            Theme(id: 5, name: "Minimalist", image: "Minimalist"),
            Theme(id: 6, name: "Traditional", image: "Traditional"),
            Theme(id: 7, name: "Garden Party", image: "GardenParty"),
        ],
        
        colors: [
            ColorPalette(id: 1, color: .blackAndWhite),
            ColorPalette(id: 2, color: .black),
            ColorPalette(id: 3, color: .white),
            ColorPalette(id: 4, color: .yellow),
            ColorPalette(id: 5, color: .orange),
            ColorPalette(id: 6, color: .red),
            ColorPalette(id: 7, color: .purple),
            ColorPalette(id: 8, color: .magenta),
            ColorPalette(id: 9, color: .green),
            ColorPalette(id: 10, color: .teal),
            ColorPalette(id: 11, color: .blue),
        ],
        
        attires: [
            Attire(id: 1, name: "Modern", image: "ModernAttire"),
            Attire(id: 2, name: "Adat", image: "AdatAttire"),
            Attire(id: 3, name: "Syar'i", image: "SyariAttire"),
        ]
    )
}

extension UserSelectedDataSourceImpl: UserSelectedDataSource {
    func getUsersSelected() -> Observable<UserSelectedModel> {
        return Observable.create { observer in
            observer.onNext(self.usersSelected)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func updateUserSelectedData(data: UserSelectedModel) {
        usersSelected = data
    }
}
