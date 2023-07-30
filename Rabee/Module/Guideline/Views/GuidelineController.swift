//
//  OnboardingController.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 27/07/23.
//

import UIKit

class GuidelineController: UIViewController {
    
    // MARK: - Variables
    private let viewModel: GuidelineViewModel = GuidelineViewModel()
    private let sharePlayViewModel: SharePlayViewModel
    
    // MARK: Life Cycle
    init(_ sharePlayViewModel: SharePlayViewModel) {
        self.sharePlayViewModel = sharePlayViewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        guidelineView.didNextBtnTapped = {
            self.navigationController?.pushViewController(GridViewController(sharePlayViewModel: self.sharePlayViewModel, gridViewModel: SelectThemeViewModel()), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    // MARK: - UI Components
    private let guidelineView: GuidelineView = {
        let view = GuidelineView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - UI Setup
    private func setupUI() {
        // Setup nav bar
        navigationItem.title = "Guideline"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?.withTintColor(UIColor.peach).withRenderingMode(.alwaysOriginal),
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(backButtonTapped))
        navigationItem.setLeftBarButton(backButton, animated: true)
        navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = .peach
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textTitle]
        
        view.backgroundColor = UIColor.whiteColor
        view.addSubview(guidelineView)
        
        NSLayoutConstraint.activate([
            guidelineView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            guidelineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            guidelineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            guidelineView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
