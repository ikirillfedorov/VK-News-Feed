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
