//
//  API.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 29.01.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import Foundation

struct API {
	static let scheme = "https"
	static let host = "api.vk.com"
	static let version = "5.103"
	static let newsFeed = "/method/newsfeed.get"
	static let user = "/method/users.get"
}
