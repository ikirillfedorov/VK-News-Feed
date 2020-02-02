//
//  NewsFeedCellLayoutCalculator.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 02.02.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

struct Sizes: FeedCellSizes {
	var postLabelFrame: CGRect
	var attachmentFrame: CGRect
	var bottomView: CGRect
	var totalHeight: CGFloat
}

enum Constants {
	static let cardViewInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
	static let topViewHeight: CGFloat = 36
	static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8)
	static let postLabelFont = UIFont.systemFont(ofSize: 14)
}

protocol FeedCellLayoutCalculatorProtocol {
	func getCellSizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
	
	private let screenWidht: CGFloat
	
	init(screenWidht: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
		self.screenWidht = screenWidht
	}
	
	func getCellSizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
		let cardViewWidht = screenWidht - Constants.cardViewInsets.left - Constants.cardViewInsets.right

		// MARK: calculating postLabel frame
		var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top),
									size: .zero)
		if let text = postText, text.isEmpty == false {
			let widht = cardViewWidht - Constants.postLabelInsets.left - Constants.postLabelInsets.right
			let height = text.height(widht: widht, font: Constants.postLabelFont)
			postLabelFrame.size = CGSize(width: widht, height: height)
		}
		return Sizes(postLabelFrame: postLabelFrame, attachmentFrame: .zero, bottomView: .zero, totalHeight: 300)
	}
}
