//
//  ExploreThumbNailModel.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 26/07/23.
//

import Foundation

struct ExploreThumbnailModel {
    let imageBanner: String
    let title: String
    let query: String
    
    static let conceptsData: [ExploreThumbnailModel] = [
        ExploreThumbnailModel(imageBanner: "RusticThemeBanner", title: "Konsep Wedding Rustic", query: "Rustic Wedding"),
        ExploreThumbnailModel(imageBanner: "ModernThemeBanner", title: "Konsep Wedding Modern", query: "Modern Wedding"),
        ExploreThumbnailModel(imageBanner: "GardenThemeBanner", title: "Konsep Wedding Garden Party", query: "Garden Party Wedding"),
        ExploreThumbnailModel(imageBanner: "MinimalistThemeBanner", title: "Konsep Wedding Minimalist", query: "Minimalist Wedding"),
        ExploreThumbnailModel(imageBanner: "VintageThemeBanner", title: "Konsep Wedding Vintage", query: "Vintage Wedding"),
        ExploreThumbnailModel(imageBanner: "BeachThemeBanner", title: "Konsep Wedding Beach", query: "Beach Wedding")
        
        
    ]
}
