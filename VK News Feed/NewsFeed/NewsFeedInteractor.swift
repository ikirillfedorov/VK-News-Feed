//
//  NewsFeedInteractor.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 31.01.2020.
//  Copyright (c) 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
	func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {
	
	var presenter: NewsFeedPresentationLogic?
	var service: NewsFeedService?
	private var fetcher = NetworkDataFetcher(networking: NetworkService())
	
	func makeRequest(request: NewsFeed.Model.Request.RequestType) {
		if service == nil {
			service = NewsFeedService()
		}
		
		switch request {
		case .getNewsFeed:
			fetcher.getFeed { [weak self] feedResponse in
				guard let self = self else { return }
				guard let feedResponse = feedResponse else { return }
				self.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse))
			}
		}
	}
}
