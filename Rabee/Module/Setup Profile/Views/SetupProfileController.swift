//
//  SetupProfileController.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 31/07/23.
//

import UIKit

class SetupProfileController: UIViewController {

    // MARK: - Variables
    private let viewModel = SetupProfileViewModel()
    
    // MARK: Life Cycle
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        // Check is user already input name and gender
        if UserDefaultsHelper.shared.getUsername() != nil &&
            UserDefaultsHelper.shared.getGender() != nil {
            self.dismiss(animated: true, completion: nil) // Destroy current Controller
            navigationController?.pushViewController(OnboardingController(), animated: true)
        }
        
        // Save User data to user default
        setupProfileView.didSaveBtnTapped = { name, gender in
            if UserDefaultsHelper.shared.getUsername() == nil &&
                UserDefaultsHelper.shared.getGender() == nil
            {
                UserDefaultsHelper.shared.saveUsername(name)
                UserDefaultsHelper.shared.saveGender(gender)
                self.navigationController?.pushViewController(OnboardingController(), animated: true)
            } else {
                print("Alredy have profile data")
            }
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
    private let setupProfileView: SetupProfileView = {
        let view = SetupProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor.whiteColor
        
        view.addSubview(setupProfileView)
        
        NSLayoutConstraint.activate([
            setupProfileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            setupProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            setupProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            setupProfileView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
