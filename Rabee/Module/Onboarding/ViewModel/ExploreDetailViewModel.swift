//
//  ExploreDetailControllerViewModel.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 26/07/23.
//

import UIKit

class ExploreDetailViewModel {
    private let useCase = UnsplashInjection().getUseCase()
    
    var responseData: [SearchResultModel] = []
    
    func getPhotos(query: String, completion: @escaping (_ result: [SearchResultModel]?, _ error: Error?) -> Void) {
        useCase.search(query: query, color: nil, page: 1) { result in
            switch result {
            case .success(let data):
                completion(data.results, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
