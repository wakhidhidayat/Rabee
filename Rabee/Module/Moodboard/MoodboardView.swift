//
//  MoodboardView.swift
//  Rabee
//
//  Created by Wahid Hidayat on 27/07/23.
//

import UIKit
import SDWebImage

class MoodboardView: UIView {
    var themePotraitUrl: String = "" {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.themePotraitImageView.sd_setImage(with: URL(string: self.themePotraitUrl))
                self.themePotraitImageView.sd_imageTransition = .fade
                self.themePotraitImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            }
        }
    }
    
    var attirePotraitUrl: String = "" {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.attirePotraitImageView.sd_setImage(with: URL(string: self.attirePotraitUrl))
                self.attirePotraitImageView.sd_imageTransition = .fade
                self.attirePotraitImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            }
        }
    }
    
    var attireLandscapeUrl: String = "" {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.attireLandscapeImageView.sd_setImage(with: URL(string: self.attireLandscapeUrl))
                self.attireLandscapeImageView.sd_imageTransition = .fade
                self.attireLandscapeImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            }
        }
    }
    
    var decorationLandscapeUrl: String = "" {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.decorationLandscapeImageView.sd_setImage(with: URL(string: self.decorationLandscapeUrl))
                self.decorationLandscapeImageView.sd_imageTransition = .fade
                self.decorationLandscapeImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            }
        }
    }
    
    var decorationPotraitUrl: String = "" {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.decorationPotraitImageView.sd_setImage(with: URL(string: self.decorationPotraitUrl))
                self.decorationPotraitImageView.sd_imageTransition = .fade
                self.decorationPotraitImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            }
        }
    }
    
    private let progressView: ProgressView = {
        let progressView = ProgressView()
        progressView.currentProgress = 4
        progressView.stepText = "4/4"
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    let exportableView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MoodboardBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let themePotraitImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.layer.borderColor = UIColor.whiteColor.cgColor
        iv.layer.borderWidth = 5
        iv.layer.shadowColor = UIColor.black.cgColor
        iv.layer.shadowOpacity = 0.5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let attireLandscapeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.layer.borderColor = UIColor.whiteColor.cgColor
        iv.layer.borderWidth = 5
        iv.layer.shadowColor = UIColor.black.cgColor
        iv.layer.shadowOpacity = 0.5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let decorationLandscapeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.layer.borderColor = UIColor.whiteColor.cgColor
        iv.layer.borderWidth = 5
        iv.layer.shadowColor = UIColor.black.cgColor
        iv.layer.shadowOpacity = 0.5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let decorationPotraitImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.layer.borderColor = UIColor.whiteColor.cgColor
        iv.layer.borderWidth = 5
        iv.layer.shadowColor = UIColor.black.cgColor
        iv.layer.shadowOpacity = 0.5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let attirePotraitImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.layer.borderColor = UIColor.whiteColor.cgColor
        iv.layer.borderWidth = 5
        iv.layer.shadowColor = UIColor.black.cgColor
        iv.layer.shadowOpacity = 0.5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nextButton: PrimaryButton = {
        let button = PrimaryButton()
        button.buttonStyle = .peach
        button.setTitle("Selesai", for: .normal)
        //        button.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
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
        addSubview(exportableView)
        exportableView.addSubview(backgroundImage)
        exportableView.addSubview(themePotraitImageView)
        exportableView.addSubview(decorationLandscapeImageView)
        exportableView.addSubview(decorationPotraitImageView)
        exportableView.addSubview(attireLandscapeImageView)
        exportableView.addSubview(attirePotraitImageView)
        addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            exportableView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 18),
            exportableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            exportableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            exportableView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -8),
            
            backgroundImage.topAnchor.constraint(equalTo: exportableView.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: exportableView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: exportableView.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: exportableView.bottomAnchor),
            
            themePotraitImageView.widthAnchor.constraint(equalToConstant: 150),
            themePotraitImageView.heightAnchor.constraint(equalToConstant: 248),
            themePotraitImageView.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 18),
            themePotraitImageView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 24),
            
            decorationLandscapeImageView.widthAnchor.constraint(equalToConstant: 266),
            decorationLandscapeImageView.heightAnchor.constraint(equalToConstant: 182),
            decorationLandscapeImageView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -18),
            decorationLandscapeImageView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 15),
            
            decorationPotraitImageView.widthAnchor.constraint(equalToConstant: 110),
            decorationPotraitImageView.heightAnchor.constraint(equalToConstant: 121),
            decorationPotraitImageView.centerYAnchor.constraint(equalTo: backgroundImage.centerYAnchor),
            decorationPotraitImageView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -18),
            
            attireLandscapeImageView.widthAnchor.constraint(equalToConstant: 176),
            attireLandscapeImageView.heightAnchor.constraint(equalToConstant: 150),
            attireLandscapeImageView.bottomAnchor.constraint(equalTo: themePotraitImageView.bottomAnchor, constant: -32),
            attireLandscapeImageView.leadingAnchor.constraint(equalTo: themePotraitImageView.trailingAnchor, constant: -32),
            
            attirePotraitImageView.widthAnchor.constraint(equalToConstant: 150),
            attirePotraitImageView.heightAnchor.constraint(equalToConstant: 220),
            attirePotraitImageView.topAnchor.constraint(equalTo: themePotraitImageView.bottomAnchor, constant: -40),
            attirePotraitImageView.leadingAnchor.constraint(equalTo: themePotraitImageView.leadingAnchor, constant: 19),
        ])
    }
}
