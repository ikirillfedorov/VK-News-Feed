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
	var moreTextButtonFrame: CGRect
	var attachmentFrame: CGRect
	var bottomView: CGRect
	var totalHeight: CGFloat
}

protocol FeedCellLayoutCalculatorProtocol {
	func getCellSizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
	
	private let screenWidht: CGFloat
	
	init(screenWidht: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
		self.screenWidht = screenWidht
	}
	
	func getCellSizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
		var showMoreTextButton = false
		let cardViewWidht = screenWidht - Constants.cardViewInsets.left - Constants.cardViewInsets.right

		// MARK: calculating postLabel frame
		var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top),
									size: .zero)
		if let text = postText, text.isEmpty == false {
			let widht = cardViewWidht - Constants.postLabelInsets.left - Constants.postLabelInsets.right
			var height = text.height(widht: widht, font: Constants.postLabelFont)
			let liminHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
			
			if height > liminHeight && isFullSizedPost == false {
				height = Constants.postLabelFont.lineHeight * Constants.minifidePostLines
				showMoreTextButton = true
			}
			
			postLabelFrame.size = CGSize(width: widht, height: height)
		}
		
		// MARK: calculating moreTextButton frame
		var moreTextButtonSize = CGSize.zero
		
		if showMoreTextButton {
			moreTextButtonSize = Constants.moreTextButtonSize
		}
		
		let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
		let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
		
		// MARK: calculating attachment frame
		let attachmentTop = postLabelFrame.size == .zero
			? Constants.postLabelInsets.top
			: moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
		var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop),
									 size: .zero)
		
		if let attachment = photoAttachments.first {
			let ratio = CGFloat(attachment.height) / CGFloat(attachment.widht)
			if photoAttachments.count == 1 {
				attachmentFrame.size = CGSize(width: cardViewWidht, height: cardViewWidht * ratio)
			} else if photoAttachments.count > 1 {
				print("more than one photo")
				attachmentFrame.size = CGSize(width: cardViewWidht, height: cardViewWidht * ratio)
			}

		}
		
		// MARK: calculating bottomView frame
		let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
		let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
									 size: CGSize(width: cardViewWidht, height: Constants.bottomViewHeight))

		// MARK: calculating cell total height
		let totalViewHeight = bottomViewFrame.maxY + Constants.cardViewInsets.bottom
		return Sizes(postLabelFrame: postLabelFrame,
					 moreTextButtonFrame: moreTextButtonFrame,
					 attachmentFrame: attachmentFrame,
					 bottomView: bottomViewFrame,
					 totalHeight: totalViewHeight)
	}
}
