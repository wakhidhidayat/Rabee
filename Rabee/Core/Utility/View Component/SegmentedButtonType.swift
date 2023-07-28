//
//  ButtonPickerStyle.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 24/07/23.
//

import UIKit

enum SegmentedButtonType {
    case primary
    case outlined

    var backgroundColor: UIColor {
        switch self {
        case .primary:
            return UIColor.peach
        case .outlined:
            return .clear
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .primary:
            return .white
        case .outlined:
            return UIColor.textBlack
        }
    }
    
    var hasBorder: Bool {
        self == .outlined
    }

}

class SegmentedButtonStyle: UIButton {
    
    var style: SegmentedButtonType = .primary {
        didSet {
            applyStyle()
        }
    }
    
    init(_ style: SegmentedButtonType = .primary) {
        super.init(frame: .zero)
        self.style = style
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        layer.cornerRadius = 4
        contentEdgeInsets = UIEdgeInsets(top: 0,left: 12,bottom: 0,right: 12)
        applyStyle()
    }
    
    func applyStyle() {
        setTitleColor(style.textColor, for: .normal)
        backgroundColor = style.backgroundColor
        layer.borderWidth = 1.2
        layer.borderColor = UIColor.peach.cgColor
    }
    

}
