//
//  OnboardingControllerViewModel.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 23/07/23.
//

import UIKit

class OnboardingViewModel {
    func getGreeting() -> NSMutableAttributedString {
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "Hello, ", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.textBlack,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .regular)
        ]))
        text.append(NSAttributedString(string: "\(UserDefaultsHelper.shared.getUsername() ?? "")", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.peach, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold)
        ]))
        return text
    }
    
    func getGenderAvatar() -> String {
        let genderString = UserDefaultsHelper.shared.getGender() ?? ""
        let gender: Gender = Gender(rawValue: genderString) ?? .man
        
        switch gender {
        case .man:
            return "ManAvatar"
        case .woman:
            return "WomanAvatar"
        }
    }
}
