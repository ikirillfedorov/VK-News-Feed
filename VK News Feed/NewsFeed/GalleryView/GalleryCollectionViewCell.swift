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
		imageView.contentMode = .scaleAspectFit
		imageView.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.addSubview(cellImageView)
		setConstraints()
		backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
