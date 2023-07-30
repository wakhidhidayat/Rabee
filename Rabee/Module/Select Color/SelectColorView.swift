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
    
    private let topColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private let bottomColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let vstackTopBottomColor: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        label.text = "PIlih salah satu dari warna yang tersedia dibawah. Klik untuk memilih dan mengetahui kesan tiap warna!"
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
        blurView.backgroundColor = .peach.withAlphaComponent(0.30)
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
        button.setTitle("Lanjut ke Busana Pernikahan", for: .normal)
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
        
        colorView.addSubview(vstackTopBottomColor)
        colorView.addSubview(colorTitleLabel)
        colorView.addSubview(descriptionLabel)
        colorView.addSubview(blurView)
        colorView.addSubview(vStack)
        
        vStack.addArrangedSubview(colorTitleLabel)
        vStack.addArrangedSubview(descriptionLabel)
        
        vstackTopBottomColor.addArrangedSubview(topColorView)
        vstackTopBottomColor.addArrangedSubview(bottomColorView)
        
        reloadData(for: nil)
        
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
            
            vStack.centerYAnchor.constraint(equalTo: vstackTopBottomColor.centerYAnchor, constant: 24),
            vStack.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 32),
            vStack.trailingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: -32),
            
            blurView.leadingAnchor.constraint(equalTo: colorView.leadingAnchor),
            blurView.bottomAnchor.constraint(equalTo: colorView.bottomAnchor),
            blurView.trailingAnchor.constraint(equalTo: colorView.trailingAnchor),
            blurView.heightAnchor.constraint(equalToConstant: 180),
            
            vstackTopBottomColor.topAnchor.constraint(equalTo: colorView.topAnchor),
            vstackTopBottomColor.bottomAnchor.constraint(equalTo: blurView.topAnchor),
            vstackTopBottomColor.widthAnchor.constraint(equalTo: colorView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 18),
            stackView.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 13),
            stackView.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -13),
            stackView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -18),
        ])
    }
    
    @objc private func colorButtonTapped(_ sender: ColorButton) {
        UIView.animate(withDuration: 1, delay: .zero) { [weak self] in
            switch sender.buttonColor {
            case .blackAndWhite:
                self?.topColorView.backgroundColor = .textBlack
                self?.bottomColorView.backgroundColor = .whiteColor
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .textBlack
                self?.colorTitleLabel.text = "Monokromatik"
                self?.descriptionLabel.text = "Menonjolkan tampilan yang elegan, komtemporer, dan klasik. Kamu juga bisa memasukkan warna lain sebagai aksen seperti rose gold dan warna pastel yang bisa menonjolkan kesan lembut, romantis namun tentunya tetap terlihat indah."
            case .black:
                self?.topColorView.backgroundColor = sender.backgroundColor
                self?.bottomColorView.backgroundColor = sender.backgroundColor
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .whiteColor
                self?.colorTitleLabel.text = "Hitam"
                self?.descriptionLabel.text = "Warna hitam memiliki arti yang elegan. Serta memiliki banyak kombinasi warna yang bisa digabungkan yaitu merah, gold, silver, agar lebih terkesan sexy dan elegan."
            case .white:
                self?.topColorView.backgroundColor = sender.backgroundColor
                self?.bottomColorView.backgroundColor = sender.backgroundColor
                self?.colorTitleLabel.textColor = .textBlack
                self?.descriptionLabel.textColor = .textBlack
                self?.colorTitleLabel.text = "Putih"
                self?.descriptionLabel.text = "Warna ini memiliki kesan yang simpel dan romantis. Warna putih juga memiliki arti positif, yaitu kesucian  dan ketulusan."
            case .yellow:
                self?.topColorView.backgroundColor = sender.backgroundColor
                self?.bottomColorView.backgroundColor = sender.backgroundColor
                self?.colorTitleLabel.textColor = .textBlack
                self?.descriptionLabel.textColor = .textBlack
                self?.colorTitleLabel.text = "Kuning"
                self?.descriptionLabel.text = "Warna Kuning memiliki arti yang gembira, muda, kebahagiaan, dan optimisme. Warna ini akan cocok jika dikombinasikan dengan warna biru dan hijau."
            case .orange:
                self?.topColorView.backgroundColor = sender.backgroundColor
                self?.bottomColorView.backgroundColor = sender.backgroundColor
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .whiteColor
                self?.colorTitleLabel.text = "Oren"
                self?.descriptionLabel.text = "Berarti sebuah keceriaan, kesuksesan, kegembiraan, dan sebuah antusiasme. Sering dipadukan dengan warna-warna lembut agar terlihat lebih cerah."
            case .red:
                self?.topColorView.backgroundColor = sender.backgroundColor
                self?.bottomColorView.backgroundColor = sender.backgroundColor
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .whiteColor
                self?.colorTitleLabel.text = "Merah"
                self?.descriptionLabel.text = "Memiliki nuansa dengan arti sesuatu yang kuat, semangat, suka cita, dan percaya diri. Untuk dekorasi pernikahan, dapat dipadukan dengan warna gold agar terlihat lebih megah dan mewah."
            case .purple:
                self?.topColorView.backgroundColor = sender.backgroundColor
                self?.bottomColorView.backgroundColor = sender.backgroundColor
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .whiteColor
                self?.colorTitleLabel.text = "Ungu"
                self?.descriptionLabel.text = "Warna ini memiliki arti kesetiaan, kekuatan yang luar biasa, dan empati. Warna ungu sering dipadukan dengan silver dan juga pink."
            case .magenta:
                self?.topColorView.backgroundColor = sender.backgroundColor
                self?.bottomColorView.backgroundColor = sender.backgroundColor
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .whiteColor
                self?.colorTitleLabel.text = "Magenta"
                self?.descriptionLabel.text = "Umumnya warna ini memiliki nuansa yang melambangkan elegansi, kemewahan, dan keanggunan."
            case .green:
                self?.topColorView.backgroundColor = sender.backgroundColor
                self?.bottomColorView.backgroundColor = sender.backgroundColor
                self?.colorTitleLabel.textColor = .textBlack
                self?.descriptionLabel.textColor = .textBlack
                self?.colorTitleLabel.text = "Hijau"
                self?.descriptionLabel.text = "Memiliki arti ketenangan, kesejukan dan kesegaran."
            case .teal:
                self?.topColorView.backgroundColor = sender.backgroundColor
                self?.bottomColorView.backgroundColor = sender.backgroundColor
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .whiteColor
                self?.colorTitleLabel.text = "Teal"
                self?.descriptionLabel.text = "Warna teal melambangkan ketenangan dan keseimbangan mental serta spiritual."
            case .blue:
                self?.topColorView.backgroundColor = sender.backgroundColor
                self?.bottomColorView.backgroundColor = sender.backgroundColor
                self?.colorTitleLabel.textColor = .whiteColor
                self?.descriptionLabel.textColor = .whiteColor
                self?.colorTitleLabel.text = "Biru"
                self?.descriptionLabel.text = "Memiliki arti yang menggambarkan ketenangan seperti halnya alam. Untuk biru muda sering dipadukan dengan baby pink. Namun bisa juga dipadukan warna putih, gold, silver, atau bahkan kuning agar terlihat lebih fresh."
            }
        }
        didColorBtnTapped?(sender)
    }
    
    @objc private func nextAction() {
        didNextBtnTapped?()
    }
    
    func reloadData(for data: UserSelectedModel?) {
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
                if let pallets = data?.colors {
                    for pallete in pallets {
                        if pallete.color == colorButton.buttonColor && pallete.usersId.count > 1 {
                            colorButton.userSelected = .couple
                        } else if pallete.color == colorButton.buttonColor && pallete.usersId.count == 1 {
                            colorButton.userSelected = .woman
                        }
                    }
                }
                
                rowStackView.addArrangedSubview(colorButton)
                buttonIndex += 1
            }
        }
    }
}

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
