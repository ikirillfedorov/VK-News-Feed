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
	
	func makeRequest(request: NewsFeed.Model.Request.RequestType) {
		if service == nil {
			service = NewsFeedService()
		}
		
		switch request {
		case .getNewsFeed:
			service?.getFeed(completion: { [weak self] revealedPostIds, feed in
				guard let self = self else { return }
				self.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealPostIds: revealedPostIds))
			})
		case .getUser:
			service?.getUser(completion: { [weak self] userResponse in
				guard let self = self else { return }
				self.presenter?.presentData(response: .presentUserInfo(userInfo: userResponse))
			})
		case .revealPostIds(let postId):
			service?.revealPostIds(forPostId: postId, completion: { [weak self] revealedPostIds, feed in
				guard let self = self else { return }
				self.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealPostIds: revealedPostIds))
			})
		case .getNextBatch:
			service?.getNextBatch(completion: { [weak self] revealedPostIds, feed in
				guard let self = self else { return }
				self.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealPostIds: revealedPostIds))
			})
		}
	}
}
