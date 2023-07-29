//
//  UserSelectedModel.swift
//  Rabee
//
//  Created by Wahid Hidayat on 24/07/23.
//

import Foundation

protocol GridModel {
    var id: Int { get }
    var name: String { get }
    var image: String { get }
    var usersId: [String] { get }
}

struct UserSelectedModel: Codable {
    let themes: [Theme]
    let colors: [ColorPalette]
    let attires: [Attire]
    var moodboard = Moodboard()
}

struct Theme: Codable, GridModel {
    let id: Int
    let name: String
    let image: String
    var usersId: [String] = []
}

struct ColorPalette: Codable {
    let id: Int
    let color: ColorFilter
    var usersId: [String] = []
}

struct Attire: Codable, GridModel {
    let id: Int
    let name: String
    let image: String
    var usersId: [String] = []
}

struct Moodboard: Codable {
    var themePotraitUrl: String? = nil
    var attirePotraitUrl: String? = nil
    var attireLandscapeUrl: String? = nil
    var decorationLandscapeUrl: String? = nil
    var decorationPotraitUrl: String? = nil
}
