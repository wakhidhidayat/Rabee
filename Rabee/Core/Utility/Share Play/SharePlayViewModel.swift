//
//  SharePlayViewModel.swift
//  Rabee
//
//  Created by Wahid Hidayat on 21/07/23.
//

import UIKit
import GroupActivities
import RxSwift

class SharePlayViewModel {
    private var tasks = Set<Task<Void, Never>>()
    private var messenger: GroupSessionMessenger?
    private let useCase = UserSelectedInjection().getUseCase()
    private let disposeBag = DisposeBag()
    
    let userSelected: BehaviorSubject<UserSelectedModel> = .init(value: UserSelectedModel(themes: [], colors: [], attires: []))
    
    func getData() {
        useCase.getUsersSelected()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] userSelected in
                self?.userSelected.onNext(userSelected)
            }
            .disposed(by: disposeBag)
    }
    
    func startSharing() {
        Task {
            do {
                _ = try await SharePlayActivity().activate()
            } catch {
                print("Failed to activate SharePlay activity: \(error)")
            }
        }
    }
    
    func configureGroupSession(_ session: GroupSession<SharePlayActivity>) {
        let messenger = GroupSessionMessenger(session: session)
        self.messenger = messenger
        
        let task = Task {
            for await (sharePlayModel, _) in messenger.messages(of: UserSelectedModel.self) {
                userSelected.onNext(sharePlayModel)
            }
        }
        tasks.insert(task)
        session.join()
    }
    
    
    func send(_ model: UserSelectedModel) {
        Task {
            do {
                try await messenger?.send(model)
            } catch {
                print("Send SharePlayModel failed: \(error)")
            }
        }
    }
    
    func selectTheme(id: Int) {
        guard let userId = UserDefaultsHelper.shared.getId() else { return }
        var userSelected = try! userSelected.value()
        var themes = userSelected.themes
        
        // remove previous selected theme from current user
        for themeIndex in 0..<themes.count {
            for userIdIndex in 0..<themes[themeIndex].usersId.count {
                if themes[themeIndex].usersId[userIdIndex] == userId {
                    themes[themeIndex].usersId.remove(at: userIdIndex)
                    break
                }
            }
        }
        
        // select theme
        for themeIndex in 0..<themes.count {
            if themes[themeIndex].id == id {
                themes[themeIndex].usersId.append(userId)
                break
            }
        }
        
        let newUserSelected = UserSelectedModel(
            themes: themes,
            colors: userSelected.colors,
            attires: userSelected.attires
        )
        
        self.userSelected.onNext(newUserSelected)
        self.useCase.updateUserSelectedData(data: newUserSelected)
        self.send(newUserSelected)
    }
    
    func selectColor(color: ColorFilter) {
        guard let userId = UserDefaultsHelper.shared.getId() else { return }
        var userSelected = try! userSelected.value()
        var colors = userSelected.colors
        
        // remove previous selected theme from current user
        for colorIndex in 0..<colors.count {
            for userIdIndex in 0..<colors[colorIndex].usersId.count {
                if colors[colorIndex].usersId[userIdIndex] == userId {
                    colors[colorIndex].usersId.remove(at: userIdIndex)
                    break
                }
            }
        }
        
        // select theme
        for colorIndex in 0..<colors.count {
            if colors[colorIndex].color == color {
                colors[colorIndex].usersId.append(userId)
                break
            }
        }
        
        let newUserSelected = UserSelectedModel(
            themes: userSelected.themes,
            colors: colors,
            attires: userSelected.attires
        )
        
        self.userSelected.onNext(newUserSelected)
        self.useCase.updateUserSelectedData(data: newUserSelected)
        self.send(newUserSelected)
    }
    
    func selectAttire(id: Int) {
        guard let userId = UserDefaultsHelper.shared.getId() else { return }
        var userSelected = try! userSelected.value()
        var attires = userSelected.attires
        
        // remove previous selected theme from current user
        for attireIndex in 0..<attires.count {
            for userIdIndex in 0..<attires[attireIndex].usersId.count {
                if attires[attireIndex].usersId[userIdIndex] == userId {
                    attires[attireIndex].usersId.remove(at: userIdIndex)
                    break
                }
            }
        }
        
        // select theme
        for attireIndex in 0..<attires.count {
            if attires[attireIndex].id == id {
                attires[attireIndex].usersId.append(userId)
                break
            }
        }
        
        let newUserSelected = UserSelectedModel(
            themes: userSelected.themes,
            colors: userSelected.colors,
            attires: attires
        )
        
        self.userSelected.onNext(newUserSelected)
        self.useCase.updateUserSelectedData(data: newUserSelected)
        self.send(newUserSelected)
    }
    
    func getSelectedTheme() -> Theme? {
        guard let userId = UserDefaultsHelper.shared.getId() else { return nil }
        var userSelected = try! userSelected.value()
        var themes = userSelected.themes
        for theme in themes {
            if theme.usersId.count > 0 {
                return theme
            }
        }
        return nil
    }
    
    func getSelectedColor() -> ColorPalette? {
        guard let userId = UserDefaultsHelper.shared.getId() else { return nil }
        var userSelected = try! userSelected.value()
        var colors = userSelected.colors
        for color in colors {
            if color.usersId.count > 0 {
                return color
            }
        }
        return nil
    }
    
    func getSelectedAttire() -> Attire? {
        guard let userId = UserDefaultsHelper.shared.getId() else { return nil }
        var userSelected = try! userSelected.value()
        var attires = userSelected.attires
        for attire in attires {
            if attire.usersId.count > 0 {
                return attire
            }
        }
        return nil
    }
}
