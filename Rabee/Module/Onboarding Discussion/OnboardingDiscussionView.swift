//
//  OnboardingDiscussionView.swift
//  Rabee
//
//  Created by Wahid Hidayat on 24/07/23.
//

import UIKit

protocol OnboardingDiscussionDelegate: AnyObject {
    func didNextBtnTapped()
    func didSharePlayBtnTapped()
}

class OnboardingDiscussionView: UIView {
    weak var delegate: OnboardingDiscussionDelegate?
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AnimationCircle")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .whiteColor
        label.textAlignment = .center
        label.text = "Wedding Theme"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let headingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Matchmaker")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .whiteColor
        label.textAlignment = .center
        label.text = "Choose Yours First, Then Decide Together!"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let onboardingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "OnboardingMatch")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .whiteColor
        label.textAlignment = .center
        label.text = "Connect with your love via SharePlay before discussing the wedding theme!"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sharePlayButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "SharePlayButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle("Go Discuss with Partner", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(backgroundImage)
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(headingImage)
        addSubview(subtitleLabel)
        addSubview(onboardingImage)
        addSubview(descriptionLabel)
        addSubview(sharePlayButton)
        addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 23),
            closeButton.heightAnchor.constraint(equalToConstant: 23),
            
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            headingImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 40),
            headingImage.heightAnchor.constraint(equalToConstant: 57),
            headingImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            headingImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            subtitleLabel.topAnchor.constraint(equalTo: headingImage.bottomAnchor, constant: 18),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            onboardingImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
            onboardingImage.heightAnchor.constraint(equalToConstant: 150),
            onboardingImage.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 60),
            onboardingImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: onboardingImage.bottomAnchor, constant: 60),
            
            sharePlayButton.widthAnchor.constraint(equalToConstant: 80),
            sharePlayButton.heightAnchor.constraint(equalToConstant: 46),
            sharePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            sharePlayButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        sharePlayButton.addTarget(self, action: #selector(sharePlayAction), for: .touchUpInside)
    }
    
    @objc private func nextAction() {
        delegate?.didNextBtnTapped()
    }
    
    @objc private func sharePlayAction() {
        delegate?.didSharePlayBtnTapped()
    }
}
