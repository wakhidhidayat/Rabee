//
//  GridViewModel.swift
//  Rabee
//
//  Created by Wahid Hidayat on 27/07/23.
//

import UIKit

protocol GridViewModel {
    var navigationTitle: String { get }
    var pageTitle: String { get }
    var currentProgress: Int { get }
    var progressText: String { get }
    var nextButtonTitle: String { get }
    
    func nextButtonAction(sharePlayViewModel: SharePlayViewModel)
}
