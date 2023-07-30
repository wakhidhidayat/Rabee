//
//  ExploreDetailView.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 26/07/23.
//

import UIKit

protocol ExploreDetailViewDelegate: AnyObject {
    func didBackButtonClicked()
}


class ExploreDetailView: UIView {
    
    // MARK: Variables
    weak var delegate: ExploreDetailViewDelegate?
    var conceptsImages: [SearchResultModel] = []
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    private let backButtonImage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        button.tintColor = UIColor.peach
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(backButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ManAvatar")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.text = "Referensi Rustic Wedding"
        label.numberOfLines = 0
        label.textColor = UIColor.textTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = StaggeredCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .whiteColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Action
    @objc func backButtonClicked() {
        delegate?.didBackButtonClicked()
    }
    
    // MARK: - UI Set Up
    private func setupUI() {
        
        self.backgroundColor = UIColor.whiteColor
        
        self.addSubview(backButtonImage)
        self.addSubview(titleLabel)
        self.addSubview(avatarImage)
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            avatarImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            backButtonImage.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor),
            backButtonImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            avatarImage.heightAnchor.constraint(equalToConstant: 40),
            avatarImage.widthAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 18),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}

extension ExploreDetailView: UICollectionViewDataSource {
    func setupCollectionView() {
        collectionView.register(StaggeredCollectionViewCell.self, forCellWithReuseIdentifier: StaggeredCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        guard let themes = try? sharePlayViewModel.data.value() else { return 0 }
        //        return themes.count
        return conceptsImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaggeredCollectionViewCell.identifier, for: indexPath) as? StaggeredCollectionViewCell
        cell?.configure(with: URL(string: conceptsImages[indexPath.row].regularImageUrl ?? "")!)
        return cell ?? UICollectionViewCell()
    }
    
}

extension ExploreDetailView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
