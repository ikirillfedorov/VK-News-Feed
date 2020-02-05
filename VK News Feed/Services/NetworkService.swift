//
//  NetworkService.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 29.01.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import Foundation

protocol Networking {
	func createRequest(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> ()) //переделатт на result
}

final class NetworkService {
	
	private let authService: AuthService
	
	init(authService: AuthService = AppDelegate.shared().authService) {
		self.authService = authService
	}
	
	private func getUrl(from path: String, params: [String: String]) -> URL? {
		var components = URLComponents()
		components.scheme = API.scheme
		components.host = API.host
		components.path = path
		components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
		return components.url
	}
	
	private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> ()) -> URLSessionDataTask {
		return URLSession.shared.dataTask(with: request) { (data, response, error) in
			DispatchQueue.main.async {
				completion(data, error)
			}
		}
	}
}

extension NetworkService: Networking {
	func createRequest(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> ()) {
		guard let token = authService.token else { return }
		var allParams = params
		allParams["access_token"] = token
		allParams["v"] = API.version
		guard let url = getUrl(from: path, params: allParams) else { return }
		let request = URLRequest(url: url)
		let task = createDataTask(from: request, completion: completion)
		task.resume()
	}
}
