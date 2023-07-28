//
//  SelectThemeCollectionViewCell.swift
//  Rabee
//
//  Created by Wahid Hidayat on 25/07/23.
//

import UIKit
import SDWebImage

class StaggeredCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "StaggeredCollectionViewCell"
    
    private let themeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
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
        
        NSLayoutConstraint.activate([
//            themeImageView.heightAnchor.constraint(equalToConstant: 250),
            themeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            themeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            themeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            themeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
        ])
    }
    
    func configure(with imageUrl: URL) {
        themeImageView.sd_setImage(with: imageUrl)
    }
}

