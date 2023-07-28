//
//  GuidelineView.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 27/07/23.
//

import UIKit

class GuidelineView: UIView {
    
    // MARK: Variables
    var guidelineData: [GuidelineModel] = GuidelineModel.GuidelineData
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.text = "Panduan membuat\nWedding Moodboard"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.textTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var guidelineTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = UIColor.whiteColor
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Action
    
    // MARK: - UI Set Up
    private func setupUI() {
        
        self.backgroundColor = .whiteColor
        
        self.addSubview(titleLabel)
        self.addSubview(guidelineTableView)

        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            guidelineTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            guidelineTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            guidelineTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            guidelineTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
}

extension GuidelineView: UITableViewDataSource {
    
    func setupTableView() {
        guidelineTableView.dataSource = self
        guidelineTableView.delegate = self
        
        guidelineTableView.register(GuidelineCell.self, forCellReuseIdentifier: GuidelineCell.identifier)
        guidelineTableView.tableFooterView = UIView()
        guidelineTableView.allowsSelection = false // Disable click row

        guidelineTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GuidelineCell.identifier, for: indexPath) as? GuidelineCell
        cell?.configure(with: guidelineData[indexPath.row], index: indexPath.row)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guidelineData.count
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension GuidelineView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
//        return 56
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        155
    }
    

}
