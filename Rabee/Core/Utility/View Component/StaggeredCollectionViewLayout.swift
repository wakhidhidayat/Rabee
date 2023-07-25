//
//  StaggeredCollectionViewLayout.swift
//  Rabee
//
//  Created by Wahid Hidayat on 25/07/23.
//

import UIKit

class StaggeredCollectionViewLayout: UICollectionViewLayout {
    // Define properties to control the layout
    private var numberOfColumns: Int = 2
    private var cellPadding: CGFloat = 20.0
    private var cache: [UICollectionViewLayoutAttributes] = []
    var yOffset: [CGFloat] = []

    override func prepare() {
        guard let collectionView = collectionView else { return }

        // Clear the cache and calculate the column width
        cache.removeAll()
        let columnWidth = (collectionView.bounds.width - CGFloat(numberOfColumns - 1) * cellPadding) / CGFloat(numberOfColumns)

        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * (columnWidth + cellPadding))
        }

        yOffset = .init(repeating: 0, count: numberOfColumns)

        var column = 0
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)

            let height = 250.0 // Replace with your logic to get item height

            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)

            yOffset[column] = yOffset[column] + height + cellPadding
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return .zero }

        var contentHeight: CGFloat = 0
        for column in 0..<numberOfColumns {
            contentHeight = max(contentHeight, yOffset[column])
        }

        return CGSize(width: collectionView.bounds.width, height: contentHeight)
    }
}
