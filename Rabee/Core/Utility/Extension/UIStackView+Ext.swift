//
//  UIStackView+Ext.swift
//  Rabee
//
//  Created by Wahid Hidayat on 27/07/23.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
