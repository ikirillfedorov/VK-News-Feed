//
//  NetworkDataFetcher.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 31.01.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import Foundation

protocol DataFetcher {
	func getFeed(response: @escaping (FeedResponse?) -> ())
}

struct NetworkDataFetcher: DataFetcher {
	
	let networking: Networking
	
	init(networking: Networking) {
		self.networking = networking
	}
	
	func getFeed(response: @escaping (FeedResponse?) -> ()) {
		let params = ["filters": "post, photo"]
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
