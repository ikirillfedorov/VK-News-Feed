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
	let dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "ru_RU")
		dateFormatter.dateFormat = "d MMM 'в' HH:mm"
		return dateFormatter
	}()
	
	func presentData(response: NewsFeed.Model.Response.ResponseType) {
		switch response {
		case .presentNewsFeed(let feed):
			let cells = feed.items.map { makeCellViewModel(from: $0, profiles: feed.profiles, groups: feed.groups) }
			let feedViewModel = FeedViewModel(cells: cells)
			viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
		}
	}
	
	private func makeCellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
		let profile = selectProfile(for: feedItem.sourceId, profiles: profiles, groups: groups)
		let date = Date(timeIntervalSince1970: feedItem.date)
		let dateTitle = dateFormatter.string(from: date)
		return FeedViewModel.Cell(iconUrlString: profile.photo,
								  name: profile.name,
								  date: dateTitle,
								  text: feedItem.text,
								  likes: String(feedItem.likes?.count ?? 0),
								  comments: String(feedItem.comments?.count ?? 0),
								  shares: String(feedItem.reposts?.count ?? 0),
								  views: String(feedItem.views?.count ?? 0),
								  photoAttachment: photoAttachment(feedItem: feedItem)
		)
	}
	
	private func selectProfile(for sourcseId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresenatable {
		let profilesOrGroups: [ProfileRepresenatable] = sourcseId >= 0 ? profiles : groups
		let normalSourceId = sourcseId >= 0 ? sourcseId : -sourcseId
		return profilesOrGroups.first { $0.id == normalSourceId }!
	}
	
	private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
		guard let photos = feedItem.attachments?.compactMap( { $0.photo } ), let firstPhoto = photos.first else { return nil }
		return FeedViewModel.FeedCellPhotoAttachment(photoUrlString: firstPhoto.imageBig,
													 widht: firstPhoto.width,
													 height: firstPhoto.height)
	}
}
