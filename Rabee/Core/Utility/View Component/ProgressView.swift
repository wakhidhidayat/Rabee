//
//  ProgressView.swift
//  Rabee
//
//  Created by Wahid Hidayat on 25/07/23.
//

import UIKit

class ProgressView: UIView {
    var stepText: String = "" {
        didSet {
            stepLabel.text = stepText
        }
    }
    
    var currentProgress: Int = 1 {
        didSet {
            progressView.progress = Float(currentProgress) / 4
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Progress Moodboard"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .textTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.trackTintColor = .peach.withAlphaComponent(0.3)
        progressView.progressTintColor = .peach
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let stepLabel: UILabel = {
        let label = UILabel()
        label.text = "1/4"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .textTitle
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        return stack
    }()
    
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        NSLayoutConstraint.activate([
            progressView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 40),
            progressView.heightAnchor.constraint(equalToConstant: 6),
        ])
        
        horizontalStack.addArrangedSubview(titleLabel)
        horizontalStack.addArrangedSubview(stepLabel)
        
        verticalStack.addArrangedSubview(horizontalStack)
        verticalStack.addArrangedSubview(progressView)
        
        addSubview(verticalStack)
        NSLayoutConstraint.activate([
            verticalStack.leadingAnchor.constraint(equalTo:leadingAnchor),
            verticalStack.topAnchor.constraint(equalTo: topAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        currentProgress = 1
        stepText = "1/4"
    }
}
