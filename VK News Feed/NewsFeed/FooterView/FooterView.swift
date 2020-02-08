//
//  FooterView.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 06.02.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

final class FooterView: UIView {
	
	private var footerLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 13)
		label.textColor = Colors.footerLabelText
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private var loader: UIActivityIndicatorView = {
		let loader = UIActivityIndicatorView()
		loader.translatesAutoresizingMaskIntoConstraints = false
		loader.hidesWhenStopped = true
		return loader
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(footerLabel)
		addSubview(loader)
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setConstraints() {
		NSLayoutConstraint.activate([
			footerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
			footerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			footerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),

			loader.centerXAnchor.constraint(equalTo: centerXAnchor),
			loader.topAnchor.constraint(equalTo: footerLabel.bottomAnchor, constant: 8),
		])
	}
	
	func showLoader() {
		loader.startAnimating()
	}
	
	func setTitle(_ title: String?) {
		loader.stopAnimating()
		footerLabel.text = title
	}
}
