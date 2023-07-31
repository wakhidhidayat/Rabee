//
//  MoodboardViewController.swift
//  Rabee
//
//  Created by Wahid Hidayat on 27/07/23.
//

import UIKit
import RxSwift

class MoodboardViewController: UIViewController {
    private let moodboardView: MoodboardView = {
        let view = MoodboardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let disposeBag = DisposeBag()
    
    private var selectedTheme: Theme? = nil
    private var selectedColor: ColorFilter? = nil
    private var selectedAttire: Attire? = nil
    
    private var shareplayViewModel: SharePlayViewModel? = nil
    private let unsplashViewModel = UnsplashViewModel(useCase: UnsplashInjection().getUseCase())
    private var localeData: Moodboards? = nil
    
    init(selectedTheme: Theme, selectedColor: ColorFilter, selectedAttire: Attire, sharePlayViewModel: SharePlayViewModel) {
        self.selectedTheme = selectedTheme
        self.selectedColor = selectedColor
        self.selectedAttire = selectedAttire
        self.shareplayViewModel = sharePlayViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    init(localeData: Moodboards) {
        self.localeData = localeData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavbar()
        setupBinding()
    }
    
    private func setupView() {
        view.addSubview(moodboardView)
        NSLayoutConstraint.activate([
            moodboardView.topAnchor.constraint(equalTo: view.topAnchor),
            moodboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moodboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moodboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        guard localeData == nil else {
            moodboardView.attireLandscapeUrl = localeData?.attireLandscapeUrl ?? ""
            moodboardView.attirePotraitUrl = localeData?.attirePotraitUrl ?? ""
            moodboardView.decorationPotraitUrl = localeData?.decorationPotraitUrl ?? ""
            moodboardView.decorationLandscapeUrl = localeData?.decorationLandscapeUrl ?? ""
            moodboardView.themePotraitUrl = localeData?.themePotraitUrl ?? ""
            return
        }
        
        guard let shareplayViewModel else { return }
        
        guard shareplayViewModel.moodboardIsEmpty() else {
            fillData()
            return
        }
        generateMoodboard()
        
        moodboardView.didNextBtnTapped = { [weak self] in
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let newMooadboard = Moodboards(context: managedContext)
            let userSelected = try? shareplayViewModel.userSelected.value()
            let name = self?.shareplayViewModel?.getSelectedTheme()?.name
            
            newMooadboard.setValue(UUID().uuidString, forKey: #keyPath(Moodboards.moodboardId))
            newMooadboard.setValue(userSelected?.moodboard.attireLandscapeUrl, forKey: #keyPath(Moodboards.attireLandscapeUrl))
            newMooadboard.setValue(userSelected?.moodboard.attirePotraitUrl, forKey: #keyPath(Moodboards.attirePotraitUrl))
            newMooadboard.setValue(userSelected?.moodboard.decorationPotraitUrl, forKey: #keyPath(Moodboards.decorationPotraitUrl))
            newMooadboard.setValue(userSelected?.moodboard.decorationLandscapeUrl, forKey: #keyPath(Moodboards.decorationLandscapeUrl))
            newMooadboard.setValue(userSelected?.moodboard.themePotraitUrl, forKey: #keyPath(Moodboards.themePotraitUrl))
            newMooadboard.setValue(name, forKey: #keyPath(Moodboards.name))
            AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
            
            DispatchQueue.main.async {
                self?.navigationController?.viewControllers = [OnboardingController()]
            }
        }
    }
    
    private func setupNavbar() {
        navigationItem.title = "Moodboard"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem?.tintColor = .peach
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareAction))
        let regenerateButton = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(regenerateAction))
        shareButton.tintColor = .peach
        regenerateButton.tintColor = .peach
        if localeData == nil {
            navigationItem.setRightBarButtonItems([shareButton, regenerateButton], animated: true)
        } else {
            navigationItem.setRightBarButtonItems([shareButton], animated: true)
        }
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func shareAction() {
        if let fileUrl = self.moodboardView.exportableView.saveImage(filename: "rabee-moodboard-\(Date()).jpg") {
            let activityController = UIActivityViewController(activityItems: [fileUrl], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        }
    }
    
    @objc private func regenerateAction() {
        generateMoodboard()
    }
    
    private func fillData() {
        let userSelected = try? shareplayViewModel?.userSelected.value()
        moodboardView.attireLandscapeUrl = userSelected?.moodboard.attireLandscapeUrl ?? ""
        moodboardView.attirePotraitUrl = userSelected?.moodboard.attirePotraitUrl ?? ""
        moodboardView.decorationPotraitUrl = userSelected?.moodboard.decorationPotraitUrl ?? ""
        moodboardView.decorationLandscapeUrl = userSelected?.moodboard.decorationLandscapeUrl ?? ""
        moodboardView.themePotraitUrl = userSelected?.moodboard.themePotraitUrl ?? ""
    }
    
    private func setupBinding() {
        shareplayViewModel?.userSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] userSelected in
                self?.fillData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Generate Moodboard
extension MoodboardViewController {
    func generateMoodboard() {
        guard let selectedTheme, let selectedColor, let selectedAttire else { return }
        
        unsplashViewModel.search(query: "\(selectedTheme.name) wedding", color: selectedColor, orientation: .portrait) { [weak self] data, error in
            guard error == nil else {
                return
            }
            
            let randomImageIndex = Int.random(in: 0..<(data?.results.count ?? 0) - 1)
            guard let imageUrl = data?.results[randomImageIndex].regularImageUrl else { return }
            self?.shareplayViewModel?.setThemeMoodboard(from: imageUrl)
            self?.moodboardView.themePotraitUrl = imageUrl
        }
        
        unsplashViewModel.search(query: "decoration \(selectedTheme.name) wedding", color: nil, orientation: .landscape) { [weak self] data, error in
            guard error == nil else {
                return
            }
            
            let randomImageIndex = Int.random(in: 0..<(data?.results.count ?? 0) - 1)
            guard let imageUrl = data?.results[randomImageIndex].regularImageUrl else { return }
            self?.shareplayViewModel?.setDecorationLandscapeMoodboard(from: imageUrl)
            self?.moodboardView.decorationLandscapeUrl = imageUrl
        }
        
        unsplashViewModel.search(query: "decoration \(selectedTheme.name) wedding", color: nil, orientation: .portrait) { [weak self] data, error in
            guard error == nil else {
                return
            }
            
            let randomImageIndex = Int.random(in: 0..<(data?.results.count ?? 0) - 1)
            guard let imageUrl = data?.results[randomImageIndex].regularImageUrl else { return }
            self?.shareplayViewModel?.setDecorationPotraitMoodboard(from: imageUrl)
            self?.moodboardView.decorationPotraitUrl = imageUrl
        }

        unsplashViewModel.search(query: "\(selectedAttire.name) wedding attire", color: nil, orientation: .landscape) { [weak self] data, error in
            guard error == nil else {
                return
            }
            
            let randomImageIndex = Int.random(in: 0..<(data?.results.count ?? 0) - 1)
            guard let imageUrl = data?.results[randomImageIndex].regularImageUrl else { return }
            self?.shareplayViewModel?.setAttireLandscapeMoodboard(from: imageUrl)
            self?.moodboardView.attireLandscapeUrl = imageUrl
        }
        
        unsplashViewModel.search(query: "\(selectedAttire.name) wedding attire", color: nil, orientation: .portrait) { [weak self] data, error in
            guard error == nil else {
                return
            }
            
            let randomImageIndex = Int.random(in: 0..<(data?.results.count ?? 0) - 1)
            guard let imageUrl = data?.results[randomImageIndex].regularImageUrl else { return }
            self?.shareplayViewModel?.setAttirePotraitMoodboard(from: imageUrl)
            self?.moodboardView.attirePotraitUrl = imageUrl
        }

    }
}
