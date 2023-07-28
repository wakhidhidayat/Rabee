//
//  SelectThemeViewModel.swift
//  Rabee
//
//  Created by Wahid Hidayat on 27/07/23.
//

import UIKit

class SelectThemeViewModel: GridViewModel{
    var navigationTitle = "Wedding Theme"
    var pageTitle = "Diskusikan dan pilih salah satu tema berikut!"
    var currentProgress = 1
    var progressText = "1/4"
    var nextButtonTitle = "Lanjut ke Pilih Warna"
    
    func nextButtonAction(sharePlayViewModel: SharePlayViewModel) {
        guard sharePlayViewModel.getSelectedTheme() != nil else {
            // TODO: Show alert
            return
        }
        
        UIApplication.topViewController()?.navigationController?.pushViewController(SelectColorViewController(sharePlayViewModel: sharePlayViewModel), animated: true)
    }
}
