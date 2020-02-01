//
//  NewsFeedCell.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 01.02.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {

	static let reuseId = "NewsFeedCell"
	
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var postLabel: UILabel!
	@IBOutlet weak var likesLabel: UIView!
	@IBOutlet weak var commentsLabel: UIView!
	@IBOutlet weak var sharesLabel: UIView!
	@IBOutlet weak var viewsLabel: UIView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }
}
