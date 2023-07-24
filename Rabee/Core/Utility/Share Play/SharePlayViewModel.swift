//
//  SharePlayViewModel.swift
//  Rabee
//
//  Created by Wahid Hidayat on 21/07/23.
//

import UIKit
import GroupActivities
import RxSwift

class SharePlayViewModel<T> where T: Codable {
    private var tasks = Set<Task<Void, Never>>()
    private var messenger: GroupSessionMessenger?
    let data: BehaviorSubject<[T]> = .init(value: [])
    
    func startSharing() {
        Task {
            do {
                _ = try await SharePlayActivity().activate()
            } catch {
                print("Failed to activate SharePlay activity: \(error)")
            }
        }
    }
        
    func configureGroupSession(_ session: GroupSession<SharePlayActivity>, messageType: T.Type) {
        let messenger = GroupSessionMessenger(session: session)
        self.messenger = messenger
        
        let task = Task {
            for await (userSelected, _) in messenger.messages(of: [T].self) {
                data.onNext(userSelected)
            }
        }
        tasks.insert(task)
        session.join()
    }
    
    func send(_ model: [T]) {
        Task {
            do {
                print(model)
                data.onNext(model)
                print(try! data.value())
                try await messenger?.send(model)
            } catch {
                print("Send SharePlayModel failed: \(error)")
            }
        }
    }

}
