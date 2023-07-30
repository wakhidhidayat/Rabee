//
//  OnboardingDiscussionViewController.swift
//  Rabee
//
//  Created by Wahid Hidayat on 25/07/23.
//

import UIKit
import GroupActivities
import RxSwift

class OnboardingDiscussionViewController: UIViewController {
    private let onboardingDiscussionView: OnboardingDiscussionView = {
        let view = OnboardingDiscussionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let groupStateObserver = GroupStateObserver()
    private let sharePlayViewModel = SharePlayViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        view.addSubview(onboardingDiscussionView)
        NSLayoutConstraint.activate([
            onboardingDiscussionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingDiscussionView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingDiscussionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingDiscussionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        onboardingDiscussionView.delegate = self
        
        onboardingDiscussionView.didBackBtnTapped = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}

extension OnboardingDiscussionViewController: OnboardingDiscussionDelegate {
    func didNextBtnTapped() {
        guard groupStateObserver.isEligibleForGroupSession else {
            AlertHelper.show(title: "Oopss!", description: "Biar makin harmonis, Kamu harus terhubung dengan pasangan kamu melalui SharePlay yaaa!", illustration: "AlertShareplay", buttonTitle: "Kembali") {
                UIApplication.topViewController()?.dismiss(animated: true)
            }
            return
        }
        
        navigationController?.pushViewController(GridViewController(sharePlayViewModel: sharePlayViewModel, gridViewModel: SelectThemeViewModel()), animated: true)
    }
    
    func didSharePlayBtnTapped() {
        if groupStateObserver.isEligibleForGroupSession {
            sharePlayViewModel.startSharing()
        } else {
            let vc = try! GroupActivitySharingController(SharePlayActivity())
            self.present(vc, animated: true)
        }
    }
}
