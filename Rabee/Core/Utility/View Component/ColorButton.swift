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
    
    var userSelected: AvatarGender? = nil {
        didSet {
            switch userSelected {
            case .man:
                setImage(UIImage(named: "ManAvatar")?.resized(to: CGSize(width: 33, height: 33)), for: .normal)
            case .woman:
                setImage(UIImage(named: "WomanAvatar")?.resized(to: CGSize(width: 33, height: 33)), for: .normal)
            case .couple:
                setImage(UIImage(named: "CoupleAvatar")?.resized(to: CGSize(width: 60, height: 33)), for: .normal)
            default:
                setImage(nil, for: .normal)
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
        
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
    }
}
