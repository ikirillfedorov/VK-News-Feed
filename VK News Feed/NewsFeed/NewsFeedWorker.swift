//
//  NewsFeedWorker.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 31.01.2020.
//  Copyright (c) 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

class NewsFeedService {

	var authService: AuthService
	var networking: Networking
	var fetcher: DataFetcher

	private var revealedPostIds = [Int]()
	private var feedResponse: FeedResponse?
	private var newFromInProcess: String?
	
	init() {
		self.authService = AppDelegate.shared().authService
		self.networking = NetworkService(authService: authService)
		self.fetcher = NetworkDataFetcher(networking: networking)
	}
	
	func getUser(completion: @escaping (UserResponse?) -> ()) {
		fetcher.getUser { userResponce in
			completion(userResponce)
		}
	}
	
	func getFeed(completion: @escaping ([Int], FeedResponse) -> ()) {
		fetcher.getFeed(nextBatchFrom: nil) { [weak self] feedResponse in
			guard let self = self else { return }
			self.feedResponse = feedResponse
			guard let feedresponse = feedResponse else { return }
			completion(self.revealedPostIds, feedresponse)
		}
	}
	
	func revealPostIds(forPostId postId: Int, completion: @escaping ([Int], FeedResponse) -> ()) {
		revealedPostIds.append(postId)
		guard let feedResponse = feedResponse else { return }
		completion(revealedPostIds, feedResponse)
	}
	
	func getNextBatch(completion: @escaping ([Int], FeedResponse) -> ()) {
		newFromInProcess = feedResponse?.nextFrom
		fetcher.getFeed(nextBatchFrom: newFromInProcess) { [weak self] feed in
			guard let self = self, let feed = feed, self.feedResponse?.nextFrom != feed.nextFrom else { return }
			if self.feedResponse == nil {
				self.feedResponse = feed
			} else {
				self.feedResponse?.items.append(contentsOf: feed.items)
				
				var profiles = feed.profiles
				if let oldProfiles = self.feedResponse?.profiles {
					let oldProfilesFiltred = oldProfiles.filter { (oldProfile) -> Bool in
						!feed.profiles.contains(where: { $0.id == oldProfile.id })
					}
					profiles.append(contentsOf: oldProfilesFiltred)
				}
				self.feedResponse?.profiles = profiles
				
				var groups = feed.groups
				if let oldGroups = self.feedResponse?.groups {
					let oldGroupsFiltred = oldGroups.filter { (oldGroup) -> Bool in
						feed.profiles.contains(where: { $0.id == oldGroup.id }) == false
					}
					groups.append(contentsOf: oldGroupsFiltred)
				}
				self.feedResponse?.groups = groups
				self.feedResponse?.nextFrom = feed.nextFrom
			}
			
			guard let feedResponse = self.feedResponse else { return }
			completion(self.revealedPostIds, feedResponse)
		}
	}
}
