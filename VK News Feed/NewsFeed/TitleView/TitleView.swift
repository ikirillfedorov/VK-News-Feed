//
//  TitleView.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 05.02.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

protocol TitleViewModel {
	var photoUrlString: String? { get }
}

final class TitleView: UIView {
	
	private var searchTextField = InsetableTextField()
	
	private var avatarView: WebImageView = {
		let imageView = WebImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
		imageView.clipsToBounds = true
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override var intrinsicContentSize: CGSize {
		return UIView.layoutFittingExpandedSize
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		avatarView.clipsToBounds = true
		avatarView.layer.cornerRadius = avatarView.frame.height / 2
	}
	
	func set(userViewModel: TitleViewModel) {
		avatarView.setImage(fromUrl: userViewModel.photoUrlString)
	}

	private func setupViews() {
		translatesAutoresizingMaskIntoConstraints = false
		addSubview(avatarView)
		addSubview(searchTextField)
	}
	
	private func setConstraints() {
		NSLayoutConstraint.activate([
			avatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
			avatarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4),
			avatarView.heightAnchor.constraint(equalTo: self.searchTextField.heightAnchor),
			avatarView.widthAnchor.constraint(equalTo: avatarView.heightAnchor),
			
			searchTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
			searchTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
			searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
			searchTextField.trailingAnchor.constraint(equalTo: avatarView.leadingAnchor, constant: -12),
		])
		
		
	}
}
