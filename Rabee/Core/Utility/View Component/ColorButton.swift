//
//  ColorButton.swift
//  Rabee
//
//  Created by Wahid Hidayat on 26/07/23.
//

import UIKit

class ColorButton: UIButton {
    var buttonColor: ColorFilter = .black {
        didSet {
            switch buttonColor {
            case .blackAndWhite:
                setBackgroundImage(UIImage(named: "BlackWhite"), for: .normal)
            case .black:
                backgroundColor = .textBlack
            case .blue:
                backgroundColor = .blue
            case .green:
                backgroundColor = .green
            case .magenta:
                backgroundColor = .magenta
            case .teal:
                backgroundColor = .systemTeal
            case .purple:
                backgroundColor = .purple
            case .red:
                backgroundColor = .red
            case .orange:
                backgroundColor = .orange
            case .yellow:
                backgroundColor = .yellow
            case .white:
                backgroundColor = .white
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
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        clipsToBounds = true
        layer.cornerRadius = 16
    }
}
