//
//  UIView+Ext.swift
//  Rabee
//
//  Created by Wahid Hidayat on 29/07/23.
//

import UIKit

extension UIView {
    func convertToImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let image = renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    func saveImage(filename: String) -> URL? {
        let image = convertToImage()
        if let data = image.jpegData(compressionQuality: 1.0) {
            let filename = getDocumentsDirectory().appendingPathComponent(filename)
            try? data.write(to: filename)
            return filename
        }
        return nil
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
