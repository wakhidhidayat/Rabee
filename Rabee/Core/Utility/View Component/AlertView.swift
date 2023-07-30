//
//  AlertView.swift
//  Rabee
//
//  Created by Wahid Hidayat on 28/07/23.
//

import UIKit

class AlertView: UIView {
    var alertTitle: String = "" {
        didSet{
            titleLabel.text = alertTitle
        }
    }
    
    var alertDescription: String = "" {
        didSet{
            descriptionLabel.text = alertDescription
        }
    }
    
    var illustrationImage: String = "" {
        didSet {
            illustationImageView.image = UIImage(named: illustrationImage)
        }
    }
    
    var buttonTitle: String = "" {
        didSet {
            button.setTitle(buttonTitle, for: .normal)
        }
    }
    
    var didButtonTapped: (() -> Void)?
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .peach
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return button
    }()
    
    private let illustationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .textBlack
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .textBlack
        return label
    }()
    
    private let button: PrimaryButton = {
        let button = PrimaryButton()
        button.buttonStyle = .peach
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private let hstackButton: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 0
        return sv
    }()
    
    private let spacerView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteColor
        return view
    }()
    
    private let vstackCloseBtnIllustationImage: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 8
        return sv
    }()
    
    private let vstackLabel: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 8
        return sv
    }()
    
    private let vstackContainer: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .whiteColor
        clipsToBounds = true
        layer.cornerRadius = 16
        
        hstackButton.addArrangedSubview(spacerView)
        hstackButton.addArrangedSubview(closeButton)
        
        vstackCloseBtnIllustationImage.addArrangedSubview(hstackButton)
        vstackCloseBtnIllustationImage.addArrangedSubview(illustationImageView)
        
        vstackLabel.addArrangedSubview(titleLabel)
        vstackLabel.addArrangedSubview(descriptionLabel)
        vstackLabel.addArrangedSubview(button)
        
        vstackContainer.addArrangedSubview(vstackCloseBtnIllustationImage)
        vstackContainer.addArrangedSubview(vstackLabel)
        
        addSubview(vstackContainer)
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 22),
            closeButton.heightAnchor.constraint(equalToConstant: 22),
            
            illustationImageView.heightAnchor.constraint(equalToConstant: 186),
            
            vstackContainer.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            vstackContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            vstackContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            vstackContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
    
    @objc private func buttonAction() {
        didButtonTapped?()
    }
    
    @objc private func closeAction() {
        UIApplication.topViewController()?.dismiss(animated: true)
    }
}
