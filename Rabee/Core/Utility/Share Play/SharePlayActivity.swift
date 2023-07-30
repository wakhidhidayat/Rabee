//
//  SharePlayActivity.swift
//  Rabee
//
//  Created by Wahid Hidayat on 24/07/23.
//

import Foundation
import GroupActivities

struct SharePlayActivity: GroupActivity {
    var metadata: GroupActivityMetadata {
        var meta = GroupActivityMetadata()
        meta.title = NSLocalizedString("Rabee", comment: "")
        meta.type = .generic
        meta.fallbackURL = URL(string: "https://apple.com")
        return meta
    }
}
