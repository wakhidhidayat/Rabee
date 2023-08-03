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
    
    func saveUsername(_ name: String) {
        UserDefaults.standard.set(name, forKey: "username")
    }
    
    func saveGender(_ gender: String) {
        UserDefaults.standard.set(gender, forKey: "gender")
    }
    
    func getId() -> String? {
        return UserDefaults.standard.string(forKey: "id")
    }
    
    func getUsername() -> String? {
        return UserDefaults.standard.string(forKey: "username")
    }
    
    func getGender() -> String? {
        return UserDefaults.standard.string(forKey: "gender")
    }

}
