//
//  OnboardingHeaderView.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 24/07/23.
//

import UIKit

enum SegmentedButton {
    case explore
    case recent
}

protocol OnboardingHeaderDelegate: AnyObject {
    func didSelectedButton(type: SegmentedButton)
}

class OnboardingHeaderView: UIView {
    
    // MARK: Variables
    weak var delegate: OnboardingHeaderDelegate?
    var didCreateBtnTapped: (() -> Void)?
    var selectedButton: SegmentedButton = .explore {
        didSet {
            switch selectedButton {
            case .explore :
                print("explore selected")
                exploreButton.style = .primary
                recentButton.style = .outlined
                // ganti cell tableview
                // ganti button
                delegate?.didSelectedButton(type: .explore)
            case.recent :
                print("recent selected")
                exploreButton.style = .outlined
                recentButton.style = .primary
                delegate?.didSelectedButton(type: .recent)
            }
        }
    }
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.text = "Yuk, buat wedding\nmoodboard sekarang!"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.textTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let createMoodboardView: UIView = {
        let view = CreateMoodboardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let createMoodboardButtonSmall: UIButton = {
        let button = UIButton()
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "arrow.right")?.withTintColor(UIColor.whiteColor)
        let fullString = NSMutableAttributedString(string: "Create your moodboard ")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        button.setAttributedTitle(fullString, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.insertSublayer(CAGradientLayer.getLinearPeach(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40, height: 210)), at: 0)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
//        button.addTarget(self, action:#selector(buttonExploreClicked), for: .touchUpInside)
        return button
    }()
    
    let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 18
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let exploreButton: SegmentedButtonStyle = {
        let button = SegmentedButtonStyle(.primary)
        button.setTitle("Explore", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 71, height: 32)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(buttonExploreClicked), for: .touchUpInside)
        return button
    }()
    
    private let recentButton: SegmentedButtonStyle = {
        let button = SegmentedButtonStyle(.outlined)
        button.setTitle("Recent Projects", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 71, height: 32)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(buttonRecentClicked), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Action
    @objc private func buttonExploreClicked() {
        selectedButton = .explore
    }
    
    @objc private func buttonRecentClicked() {
        selectedButton = .recent
    }
    
    @objc private func createButtonAction() {
        didCreateBtnTapped?()
    }
    
    
    // MARK: - UI Set Up
    private func setupUI() {
        self.addSubview(exploreButton)
        self.addSubview(recentButton)
        
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(createMoodboardView)
        
        self.addSubview(headerStackView)
        
        // Handle click event createMoodBoardView
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(createButtonAction))
        createMoodboardView.addGestureRecognizer(gesture)
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            exploreButton.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 18),
            exploreButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            exploreButton.heightAnchor.constraint(equalToConstant: 32),
            exploreButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            recentButton.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 18),
            recentButton.leadingAnchor.constraint(equalTo: exploreButton.trailingAnchor, constant: 10),
            recentButton.heightAnchor.constraint(equalToConstant: 32),
            recentButton.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }

}
