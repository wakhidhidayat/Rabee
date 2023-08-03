//
//  SetupProfileViewModel.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 02/08/23.
//

import Foundation

class SetupProfileViewModel {
    func getGender() -> Gender? {
        let genderString = UserDefaultsHelper.shared.getGender() ?? ""
        let gender: Gender = Gender(rawValue: genderString) ?? .man
        return gender
    }
    
    func getUsername() -> String? {
        UserDefaultsHelper.shared.getUsername()
    }
    
    func saveUsername(name: String) {
        UserDefaultsHelper.shared.saveUsername(name)
    }
    
    func saveGender(gender: Gender) {
        UserDefaultsHelper.shared.saveGender(gender.rawValue)
    }
}
