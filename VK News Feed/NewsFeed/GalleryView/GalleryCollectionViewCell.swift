//
//  GalleryCollectionViewCell.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 03.02.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

final class GalleryCollectionViewCell: UICollectionViewCell {
	
	static let reuseId = "GalleryCollectionViewCell"
	
	let cellImageView: WebImageView = {
		let imageView = WebImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.backgroundColor = Colors.galleryCellBGColor
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.addSubview(cellImageView)
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		cellImageView.layer.masksToBounds = true
		cellImageView.layer.cornerRadius = 10
		layer.shadowRadius = 3
		layer.shadowOpacity = 0.4
		layer.shadowOffset = CGSize(width: 2.5, height: 4)
	}
	
	override func prepareForReuse() {
		cellImageView.image = nil
	}
	
	private func setConstraints() {
		cellImageView.fillSuperview()
	}
	
	func set(imageUrl: String?) {
		cellImageView.setImage(fromUrl: imageUrl)
	}
}
