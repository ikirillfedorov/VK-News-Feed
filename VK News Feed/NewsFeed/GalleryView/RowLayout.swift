//
//  RowLayout.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 04.02.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

protocol RowLayoutDelegate: class {
	func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}

final class RowLayout: UICollectionViewLayout {
	
	weak var delegate: RowLayoutDelegate?
	
	static var numberOfRows = 2
	private var cellPadding: CGFloat = 8
	private var cache = [UICollectionViewLayoutAttributes]()
	private var contentWidht: CGFloat = 0
	private var contentHeight: CGFloat {
		guard let collectionView = collectionView else { return 0 }
		let insets = collectionView.contentInset
		return collectionView.bounds.height - (insets.left + insets.right)
	}
	
	override var collectionViewContentSize: CGSize {
		return CGSize(width: contentWidht, height: contentHeight)
	}
	
	override func prepare() {
		cache = []
		contentWidht = 0
		guard cache.isEmpty == true, let collectionView = collectionView else { return }
		var photos = [CGSize]()
		
		for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
			let indexPath = IndexPath(item: item, section: 0)
			guard let photoSize = delegate?.collectionView(collectionView, photoAtIndexPath: indexPath) else { return }
			photos.append(photoSize)
		}
		
		let superViewWidht = collectionView.frame.width
		guard var rowHeight = RowLayout.rowHeightConter(superViewWidht: superViewWidht, photosArray: photos) else { return }
		rowHeight = rowHeight / CGFloat(RowLayout.numberOfRows)
		let photosRatios = photos.map { $0.height / $0.width }
		
		var yOffset = [CGFloat]()
		for row in 0 ..< RowLayout.numberOfRows {
			yOffset.append(CGFloat(row) * rowHeight)
		}
		
		var xOffset = [CGFloat](repeating: 0, count: RowLayout.numberOfRows)
		var row = 0
		for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
			let indexPath = IndexPath(item: item, section: 0)
			let ratio = photosRatios[indexPath.row]
			let widht = rowHeight / ratio
			let frame = CGRect(x: xOffset[row], y: yOffset[row], width: widht, height: rowHeight)
			let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
			
			let arrtibute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
			arrtibute.frame = insetFrame
			cache.append(arrtibute)
			
			contentWidht = max(contentWidht, frame.maxX)
			xOffset[row] = xOffset[row] + widht
			row = row < (RowLayout.numberOfRows - 1) ? (row + 1) : 0
		}
	}
	
	static func rowHeightConter(superViewWidht: CGFloat, photosArray: [CGSize]) -> CGFloat? {
		let photoWithMinRatio = photosArray.min { (first, second) -> Bool in
			(first.height / first.width) < (second.height / second.width)
		}
		
		guard let photoWithMinRation = photoWithMinRatio else { return nil }
		let difference = superViewWidht / photoWithMinRation.width
		return photoWithMinRation.height * difference * CGFloat(RowLayout.numberOfRows)
	}
	
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
		cache.forEach { attribute in
			if attribute.frame.intersects(rect) {
				visibleLayoutAttributes.append(attribute)
			}
		}
		return visibleLayoutAttributes
	}
	
	override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		return cache[indexPath.row]
	}
}
