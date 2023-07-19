//
//  CAGradientLayer+Ext.swift
//  Rabee
//
//  Created by Wahid Hidayat on 18/07/23.
//

import UIKit

extension CAGradientLayer {
    static func getLinearPeach(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [
            UIColor.linearPeachStart.cgColor,
            UIColor.linearPeachEnd.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        return gradientLayer
    }
    
    static func getLinearAshBlue(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [
            UIColor.linearAshBlueStart.cgColor,
            UIColor.linearAshBlueEnd.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        return gradientLayer
    }
}
