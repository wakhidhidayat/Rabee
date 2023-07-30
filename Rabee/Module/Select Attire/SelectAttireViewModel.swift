//
//  SelectAttireViewModel.swift
//  Rabee
//
//  Created by Wahid Hidayat on 27/07/23.
//

import UIKit

class SelectAttireViewModel: GridViewModel{
    var navigationTitle = "Busana Pernikahan"
    var pageTitle = "Pilihlah set busana untuk pernikahan kamu!"
    var currentProgress = 3
    var progressText = "3/4"
    var nextButtonTitle = "Lanjut ke Moodboard"
    
    func nextButtonAction(sharePlayViewModel: SharePlayViewModel) {
        guard let theme = sharePlayViewModel.getSelectedTheme(),
              let color = sharePlayViewModel.getSelectedColor(),
              let attire = sharePlayViewModel.getSelectedAttire() else {
            AlertHelper.show(alertType: .notMatch)
            return
        }
        
        AlertHelper.show(title: "Yeaayy", description: "Kamu telah berhasil memilih busana pernikahan yang sama, wohooo!", illustration: "AlertMatch", buttonTitle: "Generate Moodboard") {
            UIApplication.topViewController()?.dismiss(animated: true) {
                UIApplication.topViewController()?.navigationController?.pushViewController(MoodboardViewController(selectedTheme: theme, selectedColor: color.color, selectedAttire: attire, sharePlayViewModel: sharePlayViewModel), animated: true)
            }
        }
    }
}
