//
//  NewsFeedPresenter.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 31.01.2020.
//  Copyright (c) 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
	func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
	weak var viewController: NewsFeedDisplayLogic?
	
	func presentData(response: NewsFeed.Model.Response.ResponseType) {
		switch response {
		case .presentNewsFeed(let feed):
			let cells = feed.items.map { makeCellViewModel(from: $0) }
			let feedViewModel = FeedViewModel(cells: cells)
			viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
		}
	}
	
	private func makeCellViewModel(from feedItem: FeedItem) -> FeedViewModel.Cell {
		return FeedViewModel.Cell(iconUrlString: "icon",
								  name: "name",
								  date: "data",
								  text: feedItem.text,
								  likes: String(feedItem.likes?.count ?? 0),
								  comments: String(feedItem.comments?.count ?? 0),
								  shares: String(feedItem.reposts?.count ?? 0),
								  views: String(feedItem.views?.count ?? 0))
	}
}
