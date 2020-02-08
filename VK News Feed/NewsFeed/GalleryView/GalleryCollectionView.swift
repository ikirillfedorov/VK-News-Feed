//
//  GalleryCollectionView.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 03.02.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

final class GalleryCollectionView: UICollectionView {
	
	var photos = [FeedCellPhotoAttachmentViewModel]()
	
	init() {
		let layout = RowLayout()
		super.init(frame: .zero, collectionViewLayout: layout)
		delegate = self
		dataSource = self
		layout.delegate = self
		backgroundColor = .white
		showsHorizontalScrollIndicator = false
		showsVerticalScrollIndicator = false
		register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func set(photos: [FeedCellPhotoAttachmentViewModel]) {
		self.photos = photos
		contentOffset = .zero
		reloadData()
	}
}

extension GalleryCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return photos.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath)
			as? GalleryCollectionViewCell else { return UICollectionViewCell(frame: .zero) }
		cell.set(imageUrl: photos[indexPath.row].photoUrlString)
		return cell
	}
}

extension GalleryCollectionView: RowLayoutDelegate {
	func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
		let widht = photos[indexPath.row].widht
		let height = photos[indexPath.row].height
		return CGSize(width: widht, height: height)
	}
}
