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
	private var revealedPostIds = [Int]()
	private var fetcher = NetworkDataFetcher(networking: NetworkService())
	private var feedResponse: FeedResponse?
	
	func makeRequest(request: NewsFeed.Model.Request.RequestType) {
		if service == nil {
			service = NewsFeedService()
		}
		
		switch request {
		case .getNewsFeed:
			fetcher.getFeed { [weak self] feedResponse in
				guard let self = self else { return }
				self.feedResponse = feedResponse
				self.presentFeed()
			}
		case .revealPostIds(let postId):
			revealedPostIds.append(postId)
			presentFeed()
		case .getUser:
			fetcher.getUser { [weak self] userResponse in
				guard let self = self else { return }
				self.presenter?.presentData(response: .presentUserInfo(userInfo: userResponse))
			}
		}
	}

	private func presentFeed() {
		guard let feedResponse = feedResponse else { return }
		self.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealPostIds: revealedPostIds))
	}
}
