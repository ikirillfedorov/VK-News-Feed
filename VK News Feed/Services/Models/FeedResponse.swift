//
//  FeedResponse.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 31.01.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import Foundation

struct FeedResponseWrapped: Decodable {
	let response: FeedResponse
}

struct FeedResponse: Decodable {
	var items: [FeedItem]
	var profiles: [Profile]
	var groups: [Group]
}

struct FeedItem: Decodable {
	let sourceId: Int
	let postId: Int
	let text: String?
	let date: Double
	let comments: CountableItem?
	let likes: CountableItem?
	let reposts: CountableItem?
	let views: CountableItem?
	let attachments: [Attachment]?
 }

struct Attachment: Decodable {
	let photo: Photo? 
}

struct Photo: Decodable {
	let sizes: [PhotoSize]
	var height: Int { return getPropperSize().height }
	var width: Int { return getPropperSize().width }
	var imageBig: String { return getPropperSize().url }
	
	private func getPropperSize() -> PhotoSize {
		if let photoSizeX = sizes.first(where: { $0.type == "x" } ) {
			return photoSizeX
		} else if let photoSizeZ = sizes.first(where: { $0.type == "z" } ) {
			return photoSizeZ
		} else {
			return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
		}
	}
}

struct PhotoSize: Decodable {
	let type: String
	let url: String
	let width: Int
	let height: Int
}

protocol ProfileRepresenatable {
	var id: Int { get }
	var name: String { get }
	var photo: String { get }
}

struct Profile: Decodable, ProfileRepresenatable {
	let id: Int
	private let firstName: String
	private let lastName: String
	private let photo100: String
	
	var name: String { return firstName + " " + lastName }
	var photo: String { return photo100 }
}

struct Group: Decodable, ProfileRepresenatable {
	let id: Int
	let name: String
	private let photo100: String
	
	var photo: String { return photo100 }
}

struct CountableItem: Decodable {
	let count: Int
}
