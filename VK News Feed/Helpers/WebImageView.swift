//
//  WebImageView.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 01.02.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

final class WebImageView: UIImageView {
	func setImage(fromUrl: String?) {
		guard let imageUrl = fromUrl, let url = URL(string: imageUrl) else { return }
		
		if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
			self.image = UIImage(data: cachedResponse.data)
			return
		}

		let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			guard let self = self, let data = data, let response = response else { return }
			DispatchQueue.main.async {
				self.image = UIImage(data: data)
				self.handleLoadedImage(data: data, response: response)
			}
		}
		dataTask.resume()
	}
	
	private func handleLoadedImage(data: Data, response: URLResponse) {
		guard let responseUrl = response.url else { return }
		let cachedResponse = CachedURLResponse(response: response, data: data)
		URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseUrl))
	}
}
