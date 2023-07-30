//
//  GridCollectionViewCell.swift
//  Rabee
//
//  Created by Wahid Hidayat on 25/07/23.
//

import UIKit

enum AvatarGender {
    case man
    case woman
    case couple
}

class GridCollectionViewCell: UICollectionViewCell {
    var userSelected: AvatarGender? = nil {
        didSet {
            switch userSelected {
            case .man:
                coupleAvatar.isHidden = true
                singleAvatar.isHidden = false
                singleAvatar.image = UIImage(named: "ManAvatar")
            case .woman:
                coupleAvatar.isHidden = true
                singleAvatar.isHidden = false
                singleAvatar.image = UIImage(named: "WomanAvatar")
            case .couple:
                coupleAvatar.isHidden = false
                singleAvatar.isHidden = true
                coupleAvatar.image = UIImage(named: "CoupleAvatar")
            default:
                coupleAvatar.isHidden = true
                singleAvatar.isHidden = true
            }
        }
    }
    
    private let themeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let blurView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteColor.withAlphaComponent(0.7)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .textBlack
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Info"), for: .normal)
        button.tintColor = .whiteColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let singleAvatar: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.isHidden = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let coupleAvatar: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "CoupleAvatar")
        iv.isHidden = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        backgroundColor = .whiteColor
        contentView.addSubview(themeImageView)
        contentView.addSubview(blurView)
        contentView.addSubview(infoButton)
        contentView.addSubview(singleAvatar)
        contentView.addSubview(coupleAvatar)
        blurView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            themeImageView.heightAnchor.constraint(equalToConstant: 250),
            themeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            themeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            themeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            themeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            blurView.heightAnchor.constraint(equalToConstant: 40),
            blurView.leadingAnchor.constraint(equalTo: themeImageView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: themeImageView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: themeImageView.bottomAnchor),
            
            infoButton.widthAnchor.constraint(equalToConstant: 24),
            infoButton.heightAnchor.constraint(equalToConstant: 24),
            infoButton.topAnchor.constraint(equalTo: themeImageView.topAnchor, constant: 8),
            infoButton.leadingAnchor.constraint(equalTo: themeImageView.leadingAnchor, constant: 8),
            
            nameLabel.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: blurView.centerXAnchor),
            
            singleAvatar.widthAnchor.constraint(equalToConstant: 38),
            singleAvatar.heightAnchor.constraint(equalToConstant: 38),
            singleAvatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            singleAvatar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            coupleAvatar.widthAnchor.constraint(equalToConstant: 64),
            coupleAvatar.heightAnchor.constraint(equalToConstant: 38),
            coupleAvatar.topAnchor.constraint(equalTo: singleAvatar.topAnchor),
            coupleAvatar.trailingAnchor.constraint(equalTo: singleAvatar.trailingAnchor),
            
        ])
    }
    
    func configure(with model: GridModel) {
        nameLabel.text = model.name
        themeImageView.image = UIImage(named: model.image)
    }
}
