//
//  CreateMoodboardView.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 24/07/23.
//

import UIKit

class CreateMoodboardView: UIView {

    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    private let createMoodboardBg: UIView = {
        let bg = UIView()
        bg.layer.insertSublayer(CAGradientLayer.getLinearPeach(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40, height: 210)), at: 0)
        bg.layer.cornerRadius = 12
        bg.clipsToBounds = true
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    private let createMoodboardIllustration: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "CreateMoodboardIllustration")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let createMoodboardLabel: UILabel = {
        let label = UILabel()
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "arrow.right")?.withTintColor(UIColor.whiteColor)
        let fullString = NSMutableAttributedString(string: "Buat Moodboard kamu ")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        
        label.attributedText = fullString
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor.whiteColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - UI Set Up
    private func setupUI() {
        self.addSubview(createMoodboardBg)
        self.addSubview(createMoodboardIllustration)
        self.addSubview(createMoodboardLabel)
        
        NSLayoutConstraint.activate([
            createMoodboardBg.topAnchor.constraint(equalTo: topAnchor, constant: 23),
            createMoodboardBg.bottomAnchor.constraint(equalTo: bottomAnchor),
            createMoodboardBg.leadingAnchor.constraint(equalTo: leadingAnchor),
            createMoodboardBg.trailingAnchor.constraint(equalTo: trailingAnchor),
            createMoodboardBg.heightAnchor.constraint(equalToConstant: 210),
            
            createMoodboardIllustration.topAnchor.constraint(equalTo: topAnchor),
            createMoodboardIllustration.leadingAnchor.constraint(equalTo: createMoodboardBg.leadingAnchor, constant: 20),
            createMoodboardBg.trailingAnchor.constraint(equalTo: createMoodboardIllustration.trailingAnchor, constant: 20),
            createMoodboardBg.bottomAnchor.constraint(equalTo: createMoodboardIllustration.bottomAnchor, constant: 43),
            
            createMoodboardLabel.topAnchor.constraint(equalTo: createMoodboardIllustration.bottomAnchor),
            createMoodboardLabel.bottomAnchor.constraint(equalTo: createMoodboardBg.bottomAnchor),
            createMoodboardLabel.centerXAnchor.constraint(equalTo: createMoodboardBg.centerXAnchor),

        ])
    }

}
