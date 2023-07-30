//
//  UserDefaultsHelper.swift
//  Rabee
//
//  Created by Wahid Hidayat on 23/07/23.
//

import Foundation

class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    
    func saveId(_ id: String) {
        UserDefaults.standard.set(id, forKey: "id")
    }
    
    func getId() -> String? {
        return UserDefaults.standard.string(forKey: "id")
    }
}
