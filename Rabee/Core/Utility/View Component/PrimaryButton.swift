//
//  PrimaryButton.swift
//  Rabee
//
//  Created by Wahid Hidayat on 24/07/23.
//

import UIKit

enum ButtonStyle {
    case peach
    case white
}

class PrimaryButton: UIButton {
    private var gradientLayer = CAGradientLayer()
    
    var buttonStyle: ButtonStyle = .peach {
        didSet {
            switch buttonStyle {
            case .peach:
                self.layer.insertSublayer(gradientLayer, at: 0)
                self.setTitleColor(.white, for: .normal)
            case .white:
                self.backgroundColor = .whiteColor
                self.setTitleColor(.textTitle, for: .normal)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 46).isActive = true
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 80).isActive = true
        
        clipsToBounds = true
        layer.cornerRadius = 24
        titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        
        gradientLayer = CAGradientLayer.getLinearPeach(frame: self.bounds)
        buttonStyle = .white
    }
}
