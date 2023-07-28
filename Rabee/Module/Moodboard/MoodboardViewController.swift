//
//  MoodboardViewController.swift
//  Rabee
//
//  Created by Wahid Hidayat on 27/07/23.
//

import UIKit

class MoodboardViewController: UIViewController {
    private let moodboardView: MoodboardView = {
        let view = MoodboardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let selectedTheme: Theme
    private let selectedColor: ColorFilter
    private let selectedAttire: Attire
    
    private let shareplayViewModel: SharePlayViewModel
    private let unsplashViewModel = UnsplashViewModel(useCase: UnsplashInjection().getUseCase())
    
    init(selectedTheme: Theme, selectedColor: ColorFilter, selectedAttire: Attire, sharePlayViewModel: SharePlayViewModel) {
        self.selectedTheme = selectedTheme
        self.selectedColor = selectedColor
        self.selectedAttire = selectedAttire
        self.shareplayViewModel = sharePlayViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavbar()
    }
    
    private func setupView() {
        view.addSubview(moodboardView)
        NSLayoutConstraint.activate([
            moodboardView.topAnchor.constraint(equalTo: view.topAnchor),
            moodboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moodboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moodboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        unsplashViewModel.search(query: "\(selectedTheme.name) wedding", color: selectedColor, orientation: .portrait) { [weak self] data, error in
            guard error == nil else {
                return
            }
            
            let randomImageIndex = Int.random(in: 0..<(data?.results.count ?? 0) - 1)
            guard let imageUrl = data?.results[randomImageIndex].regularImageUrl else { return }
            self?.moodboardView.themePotraitUrl = imageUrl
        }
        
        unsplashViewModel.search(query: "decoration \(selectedTheme.name) wedding", color: nil, orientation: .landscape) { [weak self] data, error in
            guard error == nil else {
                return
            }
            
            let randomImageIndex = Int.random(in: 0..<(data?.results.count ?? 0) - 1)
            guard let imageUrl = data?.results[randomImageIndex].regularImageUrl else { return }
            self?.moodboardView.decorationLandscapeUrl = imageUrl
        }
        
        unsplashViewModel.search(query: "decoration \(selectedTheme.name) wedding", color: nil, orientation: .portrait) { [weak self] data, error in
            guard error == nil else {
                return
            }
            
            let randomImageIndex = Int.random(in: 0..<(data?.results.count ?? 0) - 1)
            guard let imageUrl = data?.results[randomImageIndex].regularImageUrl else { return }
            self?.moodboardView.decorationPotraitUrl = imageUrl
        }

        unsplashViewModel.search(query: "\(selectedAttire.name) wedding attire", color: nil, orientation: .landscape) { [weak self] data, error in
            guard error == nil else {
                return
            }
            
            let randomImageIndex = Int.random(in: 0..<(data?.results.count ?? 0) - 1)
            guard let imageUrl = data?.results[randomImageIndex].regularImageUrl else { return }
            self?.moodboardView.attireLandscapeUrl = imageUrl
        }
        
        unsplashViewModel.search(query: "\(selectedAttire.name) wedding attire", color: nil, orientation: .portrait) { [weak self] data, error in
            guard error == nil else {
                return
            }
            
            let randomImageIndex = Int.random(in: 0..<(data?.results.count ?? 0) - 1)
            guard let imageUrl = data?.results[randomImageIndex].regularImageUrl else { return }
            self?.moodboardView.attirePotraitUrl = imageUrl
        }
    }
    
    private func setupNavbar() {
        navigationItem.title = "Moodboard"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem?.tintColor = .peach
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareAction))
        navigationItem.rightBarButtonItem?.tintColor = .peach
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func shareAction() {
        // TODO: Share
    }
}
