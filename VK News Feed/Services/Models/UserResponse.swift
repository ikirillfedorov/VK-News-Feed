//
//  UserResponse.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 05.02.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import Foundation

struct UserResponseWrapped: Decodable {
	let response: [UserResponse]
}

struct UserResponse: Decodable {
	let photo100: String?
}
