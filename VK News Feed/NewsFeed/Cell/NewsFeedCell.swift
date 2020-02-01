//
//  NewsFeedCell.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 01.02.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

protocol FeedCellViewModel {
	var iconUrlString: String { get }
	var name: String { get }
	var date: String { get }
	var text: String? { get }
	var likes: String? { get }
	var comments: String? { get }
	var shares: String? { get }
	var views: String? { get }
}

class NewsFeedCell: UITableViewCell {

	static let reuseId = "NewsFeedCell"
	
	@IBOutlet weak var iconImageView: WebImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var postLabel: UILabel!
	@IBOutlet weak var likesLabel: UILabel!
	@IBOutlet weak var commentsLabel: UILabel!
	@IBOutlet weak var sharesLabel: UILabel!
	@IBOutlet weak var viewsLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
    }
	
	func set(viewModel: FeedCellViewModel) {
		iconImageView.setImage(fromUrl: viewModel.iconUrlString)
		nameLabel.text = viewModel.name
		dateLabel.text = viewModel.date
		postLabel.text = viewModel.text
		likesLabel.text = viewModel.likes
		commentsLabel.text = viewModel.comments
		sharesLabel.text = viewModel.shares
		viewsLabel.text = viewModel.views
	}
}
