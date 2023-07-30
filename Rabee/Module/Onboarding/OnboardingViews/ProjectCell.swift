//
//  ProjectCell.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 24/07/23.
//

import UIKit

class ProjectCell: UITableViewCell {
    
    // MARK: - Variables
    static let identifier = "ProjectCell"
    
    // MARK: - UI Components
    
    private let projectImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "ProjectImageDummy")
        iv.layer.cornerRadius = 4
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let projectName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .textBlack
        label.text = "Moodboard Rustic"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "23 Juli 2023"
        label.textColor = .textBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 4, height: 16))
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = UIColor.textBlack
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        self.projectName.text = nil
        self.projectImage.image = nil
        self.dateLabel.text = nil
    }
    
    // MARK: - UI Set Up
    private func setupUI() {
        contentView.backgroundColor = .whiteColor
        
        contentView.addSubview(projectImage)
        contentView.addSubview(projectName)
        contentView.addSubview(dateLabel)
        contentView.addSubview(arrowImage)
        
        NSLayoutConstraint.activate([
            projectImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            projectImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            projectImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), // Give a liltle bit of padding at the leading
            projectImage.widthAnchor.constraint(equalToConstant: 56),
            projectImage.heightAnchor.constraint(equalToConstant: 56),
            
            projectName.leadingAnchor.constraint(equalTo: projectImage.trailingAnchor, constant: 12),
            projectName.topAnchor.constraint(equalTo: projectImage.topAnchor, constant: 10.5),

            dateLabel.leadingAnchor.constraint(equalTo: projectImage.trailingAnchor, constant: 12),
            dateLabel.bottomAnchor.constraint(equalTo: projectImage.bottomAnchor, constant: -10.5),
            
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            arrowImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            
        ])
    }
    
    
}

