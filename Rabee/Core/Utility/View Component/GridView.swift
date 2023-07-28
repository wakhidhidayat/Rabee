//
//  GridView.swift
//  Rabee
//
//  Created by Wahid Hidayat on 25/07/23.
//

import UIKit

class GridView: UIView {
    var didNextBtnTapped: (() -> Void)?
    
    var pageTitle: String = "" {
        didSet {
            titleLabel.text = pageTitle
        }
    }
    
    var stepText: String = "" {
        didSet {
            progressView.stepText = stepText
        }
    }
    
    var currentProgress: Int = 1 {
        didSet {
            progressView.currentProgress = currentProgress
        }
    }
    
    var nextBtnTitle: String = "" {
        didSet {
            nextButton.setTitle(nextBtnTitle, for: .normal)
        }
    }
    
    private let progressView: ProgressView = {
        let progressView = ProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .textTitle
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width / 2) - 30, height: 220)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .whiteColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let nextButton: PrimaryButton = {
        let button = PrimaryButton()
        button.buttonStyle = .peach
        button.setTitle("Lanjut ke pilih warna", for: .normal)
        button.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
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
        backgroundColor = .whiteColor
        
        addSubview(progressView)
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -16),
        ])
    }
    
    @objc private func nextAction() {
        didNextBtnTapped?()
    }
}
