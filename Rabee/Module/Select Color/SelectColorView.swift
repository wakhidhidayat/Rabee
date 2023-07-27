//
//  SelectColorView.swift
//  Rabee
//
//  Created by Wahid Hidayat on 26/07/23.
//

import UIKit

class SelectColorView: UIView {
    var didColorBtnTapped: ((_ sender: ColorButton) -> Void)?
    var didNextBtnTapped: (() -> Void)?
    
    private let progressView: ProgressView = {
        let progressView = ProgressView()
        progressView.currentProgress = 2
        progressView.stepText = "2/4"
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sesuaikan suasana warna yang kamu inginkan!"
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .textTitle
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let colorView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 24
        view.backgroundColor = .peach
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let pickColorView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = .whiteColor.withAlphaComponent(0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let colorTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        label.text = "Mood Color"
        label.textColor = .textBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.text = "PIlih salah satu dari warna yang tersedia dibawah. Klik untuk memilih dan mengetahui kesan tiap warna untuk mood wedding kamu!"
        label.textColor = .textBlack
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let blurView: UIView = {
        let blurView = UIView()
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 16
        blurView.backgroundColor = .whiteColor.withAlphaComponent(0.7)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let nextButton: PrimaryButton = {
        let button = PrimaryButton()
        button.buttonStyle = .peach
        button.setTitle("Lanjut ke Wedding Attire", for: .normal)
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
        addSubview(colorView)
        addSubview(nextButton)
        
        colorView.addSubview(colorTitleLabel)
        colorView.addSubview(descriptionLabel)
        colorView.addSubview(blurView)
        colorView.addSubview(vStack)
        
        vStack.addArrangedSubview(colorTitleLabel)
        vStack.addArrangedSubview(descriptionLabel)
        
        reloadData()
        
        blurView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            colorView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            colorView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            colorView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -16),
            
            vStack.centerYAnchor.constraint(equalTo: colorView.centerYAnchor, constant: -48),
            vStack.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 32),
            vStack.trailingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: -32),
            
            blurView.leadingAnchor.constraint(equalTo: colorView.leadingAnchor),
            blurView.bottomAnchor.constraint(equalTo: colorView.bottomAnchor),
            blurView.trailingAnchor.constraint(equalTo: colorView.trailingAnchor),
            blurView.heightAnchor.constraint(equalToConstant: 180),
            
            stackView.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 18),
            stackView.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 13),
            stackView.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -13),
            stackView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -18),
        ])
    }
    
    @objc private func colorButtonTapped(_ sender: ColorButton) {
        UIView.animate(withDuration: 1, delay: .zero) { [weak self] in
            self?.colorView.backgroundColor = sender.backgroundColor
            switch sender.buttonColor {
            case .blackAndWhite:
                self?.colorTitleLabel.textColor = .textBlack
                self?.descriptionLabel.textColor = .textBlack
            case .black:
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .whiteColor
            case .white:
                self?.colorTitleLabel.textColor = .textBlack
                self?.descriptionLabel.textColor = .textBlack
            case .yellow:
                self?.colorTitleLabel.textColor = .textBlack
                self?.descriptionLabel.textColor = .textBlack
            case .orange:
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .whiteColor
            case .red:
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .whiteColor
            case .purple:
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .whiteColor
            case .magenta:
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .whiteColor
            case .green:
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .whiteColor
            case .teal:
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .whiteColor
            case .blue:
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .whiteColor
            }
        }
        didColorBtnTapped?(sender)
    }
    
    @objc private func nextAction() {
        didNextBtnTapped?()
    }
    
    func reloadData() {
        stackView.removeAllArrangedSubviews()
        
        let buttonsPerRow = 4
        let numberOfRows = Int(ceil(Double(ColorFilter.allCases.count) / Double(buttonsPerRow)))
        
        var buttonIndex = 0
        
        for row in 0..<numberOfRows {
            let rowStackView = UIStackView()
            rowStackView.translatesAutoresizingMaskIntoConstraints = false
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 8
            
            stackView.addArrangedSubview(rowStackView)
            
            let buttonsInRow = (row == numberOfRows - 1) ? (ColorFilter.allCases.count % buttonsPerRow) : buttonsPerRow
            
            for _ in 0..<buttonsInRow {
                let colorButton = ColorButton()
                colorButton.buttonColor = ColorFilter.allCases[buttonIndex]
                colorButton.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
                
                rowStackView.addArrangedSubview(colorButton)
                buttonIndex += 1
            }
        }
    }
}
