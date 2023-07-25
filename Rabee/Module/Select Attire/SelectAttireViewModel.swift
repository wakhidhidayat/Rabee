//
//  SelectAttireViewModel.swift
//  Rabee
//
//  Created by Wahid Hidayat on 27/07/23.
//

import Foundation

class SelectAttireViewModel: GridViewModel{
    var navigationTitle = "Wedding Attire"
    var pageTitle = "Pilihlah set pakaian untuk wedding kamu!"
    var currentProgress = 3
    var progressText = "3/4"
    var nextButtonTitle = "Lanjut ke Moodboard"
    
    func nextButtonAction(sharePlayViewModel: SharePlayViewModel) {
        guard let theme = sharePlayViewModel.getSelectedTheme(),
              let color = sharePlayViewModel.getSelectedColor(),
              let attire = sharePlayViewModel.getSelectedAttire() else {
            // TODO: Show alert
            print("alert")
            return
        }
        
        // TODO: Navigate to moodboard page
    }
}
