//
//  UnsplashViewModel.swift
//  Rabee
//
//  Created by Wahid Hidayat on 20/07/23.
//

import Foundation

class UnsplashViewModel {
    private let useCase: UnsplashUseCase
    
    init(useCase: UnsplashUseCase) {
        self.useCase = useCase
    }
    
    func search(query: String, color: ColorFilter, page: Int = 1, completion: @escaping (_ data: SearchModel?, _ error: Error?) -> Void) {
        useCase.search(query: query, color: color, page: page) { result in
            switch result {
            case .success(let data):
                print(data)
                completion(data, nil)
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
}
