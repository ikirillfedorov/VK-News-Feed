//
//  Extension+String.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 02.02.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

extension String {
	func height(widht: CGFloat, font: UIFont) -> CGFloat {
		let textSize = CGSize(width: widht, height: .greatestFiniteMagnitude)
		let size = self.boundingRect(with: textSize,
									 options: .usesLineFragmentOrigin,
									 attributes: [NSAttributedString.Key.font : font],
									 context: nil)
		return ceil(size.height)
	}
}
