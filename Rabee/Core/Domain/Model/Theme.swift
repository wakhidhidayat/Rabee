//
//  Theme.swift
//  Rabee
//
//  Created by Wahid Hidayat on 24/07/23.
//

import Foundation

struct Theme: Codable {
    let id: Int
    let name: String
    let image: String
    var usersId: [String] = []
}
