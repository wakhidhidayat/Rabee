//
//  SelectThemeViewModel.swift
//  Rabee
//
//  Created by Wahid Hidayat on 27/07/23.
//

import UIKit

class SelectThemeViewModel: GridViewModel{
    var navigationTitle = "Tema Pernikahan"
    var pageTitle = "Diskusikan dan pilih salah satu tema berikut!"
    var currentProgress = 1
    var progressText = "1/4"
    var nextButtonTitle = "Lanjut ke Pilih Warna"
    
    func nextButtonAction(sharePlayViewModel: SharePlayViewModel) {
        guard sharePlayViewModel.getSelectedTheme() != nil else {
            AlertHelper.show(alertType: .notMatch)
            return
        }
        
        AlertHelper.show(title: "Yeaayy", description: "Kamu telah berhasil memilih tema pernikahan yang sama, wohooo!", illustration: "AlertMatch", buttonTitle: "Lanjut ke pilih warna") {
            UIApplication.topViewController()?.dismiss(animated: true) {
                UIApplication.topViewController()?.navigationController?.pushViewController(SelectColorViewController(sharePlayViewModel: sharePlayViewModel), animated: true)
            }
        }
    }
}
