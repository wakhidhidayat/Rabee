//
//  ExploreCell.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 25/07/23.
//

import UIKit

class ExploreCell: UITableViewCell {
    
    // MARK: - Variables
    static let identifier = "ExploreCell"
    
    // MARK: - UI Components
    private let bgRectangle: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.whiteColor
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bgShadowRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.shadowGray
         view.layer.cornerRadius = 12
         view.clipsToBounds = true
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
    }()
    
    private let exploreBanner: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "ProjectBannerSkeleton")
//        iv.layer.cornerRadius = 4
//        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let exploreTitle: UILabel = {
        let label = UILabel()
        label.textColor = .textBlack
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "Moodboard Rustic"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separator: UIView = {
       let line = UIView()
        line.backgroundColor = UIColor.separatorGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.exploreTitle.text = nil
        self.exploreBanner.image = nil
    }
    
    // MARK: - UI Set Up
    private func setupUI() {
        
        contentView.backgroundColor = .whiteColor
        
        contentView.addSubview(bgShadowRectangle)
        contentView.addSubview(bgRectangle)
        contentView.addSubview(exploreBanner)
        contentView.addSubview(separator)
        contentView.addSubview(exploreTitle)
        
        NSLayoutConstraint.activate([
            
            bgShadowRectangle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            bgShadowRectangle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bgShadowRectangle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bgShadowRectangle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            bgRectangle.topAnchor.constraint(equalTo: bgShadowRectangle.topAnchor),
            bgRectangle.bottomAnchor.constraint(equalTo: bgShadowRectangle.bottomAnchor, constant: -6),
            bgRectangle.leadingAnchor.constraint(equalTo: bgShadowRectangle.leadingAnchor),
            bgRectangle.trailingAnchor.constraint(equalTo: bgShadowRectangle.trailingAnchor),
            
            exploreBanner.topAnchor.constraint(equalTo: bgRectangle.topAnchor, constant: 10),
            exploreBanner.leadingAnchor.constraint(equalTo: bgRectangle.leadingAnchor, constant: 15),
            exploreBanner.trailingAnchor.constraint(equalTo: bgRectangle.trailingAnchor, constant: -15),
            exploreBanner.heightAnchor.constraint(equalToConstant: 108),
            
            separator.topAnchor.constraint(equalTo: exploreBanner.bottomAnchor, constant: 5),
            separator.leadingAnchor.constraint(equalTo: bgRectangle.leadingAnchor, constant: 15),
            separator.trailingAnchor.constraint(equalTo: bgRectangle.trailingAnchor, constant: -15),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            exploreTitle.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8),
            exploreTitle.bottomAnchor.constraint(equalTo: bgRectangle.bottomAnchor, constant: -8),
            exploreTitle.leadingAnchor.constraint(equalTo: bgRectangle.leadingAnchor, constant: 15)
            
        ])
    }
    
    func configure(with conceptsData: ExploreThumbnailModel) {
        exploreBanner.image = UIImage(named: conceptsData.imageBanner)
        exploreTitle.text = conceptsData.title
    }
}


