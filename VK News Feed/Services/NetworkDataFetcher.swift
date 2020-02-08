//
//  NetworkDataFetcher.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 31.01.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import Foundation

protocol DataFetcher {
	func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> ())
	func getUser(response: @escaping (UserResponse?) -> ())
}

struct NetworkDataFetcher: DataFetcher {
	
	let networking: Networking
	private let authService: AuthService
	
	init(networking: Networking, authService: AuthService = AppDelegate.shared().authService) {
		self.networking = networking
		self.authService = authService
	}
	
	func getUser(response: @escaping (UserResponse?) -> ()) {
		guard let userId = authService.userId else { return }
		let params = ["user_ids": userId, "fields": "photo_100"]
		networking.createRequest(path: API.user, params: params) { data, error in
			if let error = error {
				print("Error received requsting data: \(error.localizedDescription)")
				response(nil)
			}
			let userResponse = self.decodeJSON(type: UserResponseWrapped.self, from: data)
			response(userResponse?.response.first)
		}
	}

	func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> ()) {
		var params = ["filters": "post, photo"]
		params["start_from"] = nextBatchFrom
		networking.createRequest(path: API.newsFeed, params: params) { data, error in
			if let error = error {
				print("Error received requsting data: \(error.localizedDescription)")
				response(nil)
			}
			let feedResponse = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
			response(feedResponse?.response)
		}
	}
	
	private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		guard let data = data else { return nil }
		guard let response = try? decoder.decode(type, from: data) else { return nil }
		return response
	}
}
