//
//  FeedSceneView.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 01.02.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

final class FeedSceneView: UIView {
	let tableView = UITableView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubViews()
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupSubViews() {
		self.addSubview(tableView)
	}
	
	private func setConstraints() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: self.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
		])
	}
	
	
	
}
