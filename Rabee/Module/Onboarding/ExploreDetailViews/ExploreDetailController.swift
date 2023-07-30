//
//  ExploreDetailViewController.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 25/07/23.
//

import UIKit

class ExploreDetailController: UIViewController {

    // MARK: - Variables
    private let viewModel: ExploreDetailViewModel
    private let query: String
    
    // MARK: Life Cycle
    init(_ viewModel: ExploreDetailViewModel = ExploreDetailViewModel(), query: String) {
        self.viewModel = viewModel
        self.query = query
        super.init(nibName: nil, bundle: nil)
        
        exploreDetailView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.getPhotos(query: query) { [weak self] result, error in
            guard error == nil, let result else {
                return
            }
            
            self?.exploreDetailView.conceptsImages = result
            self?.exploreDetailView.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    // MARK: - UI Components
    private let exploreDetailView: ExploreDetailView = {
        let view = ExploreDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - UI Setup
    private func setupUI() {
        
        view.backgroundColor = UIColor.whiteColor
        
        view.addSubview(exploreDetailView)
        
        exploreDetailView.titleLabel.text = "Referensi \(query)"
        
        NSLayoutConstraint.activate([
            exploreDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            exploreDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            exploreDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            exploreDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc func ButtonTapped() {
        print("Button Tapped")
       }

}

extension ExploreDetailController: ExploreDetailViewDelegate {
    func didBackButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}
