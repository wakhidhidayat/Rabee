//
//  OnboardingView.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 23/07/23.
//

import UIKit
import CoreData

class OnboardingController: UIViewController {
    
    // MARK: - Variables
    private let viewModel: OnboardingViewModel
    
    // MARK: Life Cycle
    init(_ viewModel: OnboardingViewModel = OnboardingViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        onboardingView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        onboardingView.headerView.didCreateBtnTapped = {
            self.navigationController?.pushViewController(OnboardingDiscussionViewController(), animated: true)
        }

        getMoodboards()

        onboardingView.messageText = viewModel.getGreeting()
        onboardingView.avatarImageString = viewModel.getGenderAvatar()

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
    private let onboardingView: OnboardingView = {
        let view = OnboardingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor.whiteColor
        
        view.addSubview(onboardingView)
        
        NSLayoutConstraint.activate([
            onboardingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func getMoodboards() {
        let noteFetch: NSFetchRequest<Moodboards> = Moodboards.fetchRequest()
        do {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let results = try managedContext.fetch(noteFetch)
            onboardingView.moodboards = results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
}

extension OnboardingController: OnboardingViewDelegate {
    func didSelectRow(type: SegmentedButton, query: String) {
        // Access the navigation controller and perform navigation
        if let navigationController = navigationController {
            if (type == .explore) {
                let vm = ExploreDetailViewModel()
                let vc = ExploreDetailController(vm, query: query)
                navigationController.pushViewController(vc, animated: true)
            }
        }
    }
}
