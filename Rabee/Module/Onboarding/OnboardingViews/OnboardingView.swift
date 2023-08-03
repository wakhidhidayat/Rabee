//
//  OnboardingView.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 25/07/23.
//

import UIKit

protocol OnboardingViewDelegate: AnyObject {
    func didSelectRow(type: SegmentedButton, query: String)
}

class OnboardingView: UIView {

    // MARK: Variables
    var headerViewTopConstraint: NSLayoutConstraint?
    weak var delegate: OnboardingViewDelegate?
    let conceptsData = ExploreThumbnailModel.conceptsData
    var moodboards: [Moodboards] = [Moodboards]() {
        didSet {
            self.projectTableView.reloadData()
        }
    }
    
    var messageText: NSMutableAttributedString = NSMutableAttributedString(string: "") {
        didSet {
            greetMessage.attributedText = messageText
        }
    }
    
    var avatarImageString: String = "MenAvatar" {
        didSet {
            avatarImage.image = UIImage(named: avatarImageString)
        }
    }
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupTableView()
        headerView.delegate = self
        
        headerView.selectedButton = .explore
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    private let greetMessage: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString()
        label.attributedText = text
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let avatarImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        image.image = UIImage(named: "WomanAvatar")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let greetStackView: UIStackView = {
        let greetSV = UIStackView()
        greetSV.axis = .horizontal
        greetSV.spacing = 10
        greetSV.distribution = .fill
        greetSV.backgroundColor = UIColor.whiteColor
        greetSV.translatesAutoresizingMaskIntoConstraints = false
        return greetSV
    }()
    
    let headerView: OnboardingHeaderView = {
        let header = OnboardingHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private lazy var exploreTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = UIColor.whiteColor
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var projectTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = UIColor.whiteColor
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
   
    private let topBgView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Action
    
    
    // MARK: - UI Set Up
    private func setupUI() {
        
        self.backgroundColor = UIColor.whiteColor
        
        self.addSubview(headerView)
        self.addSubview(exploreTableView)
        self.addSubview(projectTableView)
        
        greetStackView.addArrangedSubview(greetMessage)
        greetStackView.addArrangedSubview(avatarImage)
        self.addSubview(greetStackView)
        self.addSubview(topBgView)
        
        headerViewTopConstraint = headerView.topAnchor.constraint(equalTo: greetStackView.bottomAnchor, constant: 18)
        
        NSLayoutConstraint.activate([
            avatarImage.heightAnchor.constraint(equalToConstant: 40),
            avatarImage.widthAnchor.constraint(equalToConstant: 40),
            
            greetStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            greetStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            greetStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            topBgView.topAnchor.constraint(equalTo: self.topAnchor, constant: -100),
            topBgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topBgView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topBgView.bottomAnchor.constraint(equalTo: greetStackView.topAnchor),
            
            headerViewTopConstraint!,
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            exploreTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            exploreTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            exploreTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            exploreTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            projectTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            projectTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            projectTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            projectTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}


extension OnboardingView: OnboardingHeaderDelegate {
    func didSelectedButton(type: SegmentedButton) {
        switch type {
        case .explore:
            exploreTableView.isHidden = false
            projectTableView.isHidden = true
        case .recent:
            exploreTableView.isHidden = true
            projectTableView.isHidden = false
        }
    }
}

extension OnboardingView: UITableViewDataSource {
    
    func setupTableView() {
        exploreTableView.dataSource = self
        exploreTableView.delegate = self
        projectTableView.dataSource = self
        projectTableView.delegate = self
        
        exploreTableView.register(ExploreCell.self, forCellReuseIdentifier: ExploreCell.identifier)
        exploreTableView.tableFooterView = UIView()
        projectTableView.register(ProjectCell.self, forCellReuseIdentifier: ProjectCell.identifier)
        projectTableView.tableFooterView = UIView()

        exploreTableView.reloadData()
        projectTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == exploreTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: ExploreCell.identifier, for: indexPath) as? ExploreCell
            cell?.configure(with: conceptsData[indexPath.row])
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProjectCell.identifier, for: indexPath) as? ProjectCell
            if moodboards.count > 0 {
                cell?.configure(with: moodboards[indexPath.row])
            }
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == exploreTableView {
            return conceptsData.count
        } else {
            // Handle Recent projects numOfRows
            return moodboards.count
        }
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == exploreTableView {
            // Handle exploreTableView cell clicked
            exploreTableView.deselectRow(at: indexPath, animated: true)
            delegate?.didSelectRow(type: .explore, query: conceptsData[indexPath.row].query)
        } else {
            let moodboardViewContorller = MoodboardViewController(localeData: moodboards[indexPath.row])
            UIApplication.topViewController()?.navigationController?.pushViewController(moodboardViewContorller, animated: true)
        }
        
    }
}

extension OnboardingView: UITableViewDelegate {
    
    // Animating Scrollview
    // Snap to position
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        let swipingDown = y <= 0
        let shouldSnap = y > 30
        let headerHeight = headerView.headerStackView.frame.height - 90 // 90 is height of createMoodBoardSmall + 18 margin
        
        // Give Disappeare animation
        UIView.animate(withDuration: 0.3) {
            self.headerView.createMoodboardView.alpha = swipingDown ? 1.0 : 0.0
            self.headerView.titleLabel.alpha = swipingDown ? 1.0 : 0.0
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            self.headerViewTopConstraint?.constant = shouldSnap ? -headerHeight : 18
            self.layoutIfNeeded()
            
           
        })
        if shouldSnap {
            self.headerView.createMoodboardButtonSmall.isHidden = false
        } else {
            self.headerView.createMoodboardButtonSmall.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
