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
	var photoAttachments: [FeedCellPhotoAttachmentViewModel] { get }
	var sizes: FeedCellSizes { get } 
}

protocol FeedCellSizes {
	var postLabelFrame: CGRect { get }
	var attachmentFrame: CGRect { get }
	var bottomView: CGRect { get }
	var totalHeight: CGFloat { get }
	var moreTextButtonFrame: CGRect { get }
}

protocol FeedCellPhotoAttachmentViewModel {
	var photoUrlString: String? { get }
	var widht: Int { get }
	var height: Int { get }
}


class NewsFeedCell: UITableViewCell {

	static let reuseId = "NewsFeedCell"
	@IBOutlet weak var cardView: UIView!
	
	@IBOutlet weak var iconImageView: WebImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var postLabel: UILabel!
	@IBOutlet weak var likesLabel: UILabel!
	@IBOutlet weak var commentsLabel: UILabel!
	@IBOutlet weak var sharesLabel: UILabel!
	@IBOutlet weak var viewsLabel: UILabel!
	@IBOutlet weak var postImageView: WebImageView!
	@IBOutlet weak var bottomView: UIView!
	
	override func prepareForReuse() {
		iconImageView.setImage(fromUrl: nil)
		postImageView.setImage(fromUrl: nil)
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
		iconImageView.clipsToBounds = true
		cardView.layer.cornerRadius = 10
		cardView.clipsToBounds = true
		backgroundColor = .clear
		selectionStyle = .none
    }
	
//	func set(viewModel: FeedCellViewModel) {
//		iconImageView.setImage(fromUrl: viewModel.iconUrlString)
//		nameLabel.text = viewModel.name
//		dateLabel.text = viewModel.date
//		postLabel.text = viewModel.text
//		likesLabel.text = viewModel.likes
//		commentsLabel.text = viewModel.comments
//		sharesLabel.text = viewModel.shares
//		viewsLabel.text = viewModel.views
//		
//		postLabel.frame = viewModel.sizes.postLabelFrame
//		postImageView.frame = viewModel.sizes.attachmentFrame
//		bottomView.frame = viewModel.sizes.bottomView
//		
//		if let photoAttachment = viewModel.photoAttachment {
//			postImageView.setImage(fromUrl: photoAttachment.photoUrlString)
//			postImageView.isHidden = false
//		} else {
//			postImageView.isHidden = true
//		}
//	}
}
