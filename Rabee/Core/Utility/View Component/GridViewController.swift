//
//  GridViewController.swift
//  Rabee
//
//  Created by Wahid Hidayat on 25/07/23.
//

import UIKit
import RxSwift

class GridViewController: UIViewController {
    private let gridView: GridView = {
        let view = GridView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gridViewModel: GridViewModel
    private let disposeBag = DisposeBag()
    private let sharePlayViewModel: SharePlayViewModel
    
    init(sharePlayViewModel: SharePlayViewModel, gridViewModel: GridViewModel) {
        self.sharePlayViewModel = sharePlayViewModel
        self.gridViewModel = gridViewModel
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
        sharePlayViewModel.getData()
    }
    
    private func setupNavbar() {
        navigationItem.title = gridViewModel.navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem?.tintColor = .peach
    }
    
    private func setupView() {
        view.addSubview(gridView)
        NSLayoutConstraint.activate([
            gridView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gridView.topAnchor.constraint(equalTo: view.topAnchor),
            gridView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gridView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        gridView.collectionView.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "GridCollectionViewCell")
        gridView.collectionView.dataSource = self
        gridView.collectionView.reloadData()
        gridView.collectionView.delegate = self
        
        gridView.didNextBtnTapped = { [weak self] in
            guard let self else { return }
            self.gridViewModel.nextButtonAction(sharePlayViewModel: self.sharePlayViewModel)
        }
        
        gridView.pageTitle = gridViewModel.pageTitle
        gridView.currentProgress = gridViewModel.currentProgress
        gridView.stepText = gridViewModel.progressText
        gridView.nextBtnTitle = gridViewModel.nextButtonTitle
    }
    
    private func setupBinding() {
        async {
            for await session in SharePlayActivity.sessions() {
                sharePlayViewModel.configureGroupSession(session)
            }
        }
        
        sharePlayViewModel.userSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] userSelected in
                self?.gridView.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
}

extension GridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let userSelected = try? sharePlayViewModel.userSelected.value() else { return 0 }
        if gridViewModel is SelectThemeViewModel {
            return userSelected.themes.count
        } else {
            return userSelected.attires.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCollectionViewCell", for: indexPath) as? GridCollectionViewCell
        guard let userSelected = try? sharePlayViewModel.userSelected.value() else { return cell ?? UICollectionViewCell() }
        
        var data: [GridModel] = []
        
        if gridViewModel is SelectThemeViewModel {
            data = userSelected.themes
        } else {
            data = userSelected.attires
        }
        
        cell?.configure(with: data[indexPath.row])
        if data[indexPath.row].usersId.isEmpty {
            cell?.userSelected = nil
        } else if data[indexPath.row].usersId.count > 1 {
            cell?.userSelected = .couple
        } else {
            cell?.userSelected = .woman
        }
        return cell ?? UICollectionViewCell()
    }
}

extension GridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let userSelected = try? sharePlayViewModel.userSelected.value() else { return }
        if gridViewModel is SelectThemeViewModel {
            sharePlayViewModel.selectTheme(id: userSelected.themes[indexPath.row].id)
        } else {
            sharePlayViewModel.selectAttire(id: userSelected.attires[indexPath.row].id)
        }
    }
}
