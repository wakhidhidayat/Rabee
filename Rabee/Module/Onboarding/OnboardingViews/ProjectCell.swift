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
        iv.image = UIImage(named: "MenAvatar")
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
        self.addSubview(projectImage)
        self.addSubview(projectName)
        self.addSubview(dateLabel)
        self.addSubview(arrowImage)
        
        NSLayoutConstraint.activate([
            projectImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            projectImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            projectImage.leadingAnchor.constraint(equalTo: leadingAnchor), // Give a liltle bit of padding at the leading
            projectImage.widthAnchor.constraint(equalToConstant: 56),
            projectImage.heightAnchor.constraint(equalToConstant: 56),
            
            projectName.leadingAnchor.constraint(equalTo: projectImage.trailingAnchor, constant: 12),
            projectName.topAnchor.constraint(equalTo: projectImage.topAnchor, constant: 10.5),

            dateLabel.leadingAnchor.constraint(equalTo: projectImage.trailingAnchor, constant: 12),
            dateLabel.bottomAnchor.constraint(equalTo: projectImage.bottomAnchor, constant: -10.5),
            
            arrowImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            arrowImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            
        ])
    }
    
    
}

