//
//  SelectColorViewController.swift
//  Rabee
//
//  Created by Wahid Hidayat on 27/07/23.
//

import UIKit
import RxSwift

class SelectColorViewController: UIViewController {
    private let selectColorView: SelectColorView = {
        let selectColorView = SelectColorView()
        selectColorView.translatesAutoresizingMaskIntoConstraints = false
        return selectColorView
    }()
    
    private let disposeBag = DisposeBag()
    private let sharePlayViewModel: SharePlayViewModel
    
    init(sharePlayViewModel: SharePlayViewModel) {
        self.sharePlayViewModel = sharePlayViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupView()
        setupBinding()
    }
    
    private func setupView() {
        view.addSubview(selectColorView)
        NSLayoutConstraint.activate([
            selectColorView.topAnchor.constraint(equalTo: view.topAnchor),
            selectColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectColorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectColorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        selectColorView.didColorBtnTapped = { [weak self] sender in
            self?.sharePlayViewModel.selectColor(color: sender.buttonColor)
        }
        
        selectColorView.didNextBtnTapped = { [weak self] in
            guard let self, sharePlayViewModel.getSelectedColor() != nil else {
                AlertHelper.show(alertType: .notMatch)
                return
            }
            
            AlertHelper.show(title: "Yeaayy", description: "Kamu telah berhasil memilih warna tema pernikahan yang sama, wohooo!", illustration: "AlertMatch", buttonTitle: "Lanjut ke pilih busana pernikahan") { [weak self] in
                guard let self else { return }
                UIApplication.topViewController()?.dismiss(animated: true) { [weak self] in
                    guard let self else { return }
                    navigationController?.pushViewController(GridViewController(sharePlayViewModel: sharePlayViewModel, gridViewModel: SelectAttireViewModel()), animated: true)
                }
            }
        }
    }
    
    private func setupBinding() {
        sharePlayViewModel.userSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] userSelected in
                self?.selectColorView.reloadData(for: userSelected)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupNavbar() {
        navigationItem.title = "Warna"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem?.tintColor = .peach
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
}
