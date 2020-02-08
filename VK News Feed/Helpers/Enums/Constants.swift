//
//  Constants.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 02.02.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

enum Constants {
	static let cardViewInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
	static let topViewHeight: CGFloat = 60
	static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8)
	static let postLabelFont = UIFont.systemFont(ofSize: 14)
	static let bottomViewHeight: CGFloat = 44
	static let bottomViewViewsWidth: CGFloat = 80
	static let bottomViewViewsIconSize: CGFloat = 24
	static let minifiedPostLimitLines: CGFloat = 8
	static let minifidePostLines: CGFloat = 6
	static let moreTextButtonSize = CGSize(width: 170, height: 30)
	static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
}
