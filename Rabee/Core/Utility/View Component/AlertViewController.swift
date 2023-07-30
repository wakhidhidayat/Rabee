//
//  AlertViewController.swift
//  Rabee
//
//  Created by Wahid Hidayat on 28/07/23.
//

import UIKit

enum AlertType {
    case notMatch
}

fileprivate class AlertViewController: UIViewController {
    private let alertView: AlertView = {
        let alertView = AlertView()
        alertView.translatesAutoresizingMaskIntoConstraints = false
        return alertView
    }()
    
    private let alertTitle: String
    private let alertDescription: String
    private let illustrationImage: String
    private let buttonTitle: String
    private let buttonAction: (() -> Void)?
    
    fileprivate init(alertTitle: String, alertDescription: String, illustrationImage: String, buttonTitle: String, buttonAction: (() -> Void)?) {
        self.alertTitle = alertTitle
        self.alertDescription = alertDescription
        self.illustrationImage = illustrationImage
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
        super.init(nibName: nil, bundle: nil)
    }
    
    fileprivate init(type: AlertType) {
        switch type {
        case .notMatch:
            self.alertTitle = "Yuk, satukan pilihan kamu!"
            self.alertDescription = "Kamu dan pasanganmu memilih pilihan yang berbeda nih, diskusiin lagi yuk biar pilihan kalian sama"
            self.illustrationImage = "AlertNotMatch"
            self.buttonTitle = "Kembali"
            self.buttonAction = {
                UIApplication.topViewController()?.dismiss(animated: true)
            }
            super.init(nibName: nil, bundle: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup blur background
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.addSubview(alertView)
        
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        alertView.alertTitle = alertTitle
        alertView.alertDescription = alertDescription
        alertView.illustrationImage = illustrationImage
        alertView.buttonTitle = buttonTitle
        alertView.didButtonTapped = buttonAction
    }
}

class AlertHelper {
    private init() {}
    
    static func show(title: String, description: String, illustration: String, buttonTitle: String, buttonAction: (() -> Void)?) {
        let alert = AlertViewController(alertTitle: title, alertDescription: description, illustrationImage: illustration, buttonTitle: buttonTitle, buttonAction: buttonAction)
        alert.modalPresentationStyle = .overFullScreen
        UIApplication.topViewController()?.present(alert, animated: true)
    }
    
    static func show(alertType: AlertType) {
        let alert = AlertViewController(type: alertType)
        alert.modalPresentationStyle = .overFullScreen
        UIApplication.topViewController()?.present(alert, animated: true)
    }
}
