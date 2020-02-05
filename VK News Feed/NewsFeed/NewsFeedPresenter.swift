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
	var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
	
	let dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "ru_RU")
		dateFormatter.dateFormat = "d MMM 'в' HH:mm"
		return dateFormatter
	}()
	
	func presentData(response: NewsFeed.Model.Response.ResponseType) {
		switch response {
		case .presentNewsFeed(let feed, let revealPostIds):
			let cells = feed.items.map { makeCellViewModel(from: $0, profiles: feed.profiles, groups: feed.groups, revealPostIds: revealPostIds) }
			let feedViewModel = FeedViewModel(cells: cells)
			viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
		case .presentUserInfo(let userInfo):
			let userViewModel = UserViewmodel(photoUrlString: userInfo?.photo100)
			viewController?.displayData(viewModel: .displayUserInfo(userInfo: userViewModel))
		}
	}
	
	private func makeCellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealPostIds: [Int]) -> FeedViewModel.Cell {
		let profile = selectProfile(for: feedItem.sourceId, profiles: profiles, groups: groups)
		let photoAttachments = self.getPhotoAttachments(feedItem: feedItem)
		let date = Date(timeIntervalSince1970: feedItem.date)
		let dateTitle = dateFormatter.string(from: date)
		let isFullSized = revealPostIds.contains { $0 == feedItem.postId }
		let sizes = cellLayoutCalculator.getCellSizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizedPost: isFullSized)
		let posText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
		return FeedViewModel.Cell(postId: feedItem.postId,
								  iconUrlString: profile.photo,
								  name: profile.name,
								  date: dateTitle,
								  text: posText,
								  likes: formattedCounter(feedItem.likes?.count),
								  comments: formattedCounter(feedItem.comments?.count),
								  shares: formattedCounter(feedItem.reposts?.count),
								  views: formattedCounter(feedItem.views?.count),
								  photoAttachments: photoAttachments,
								  sizes: sizes)
	}
	
	private func formattedCounter(_ counter: Int?) -> String? {
		guard let counter = counter, counter > 0 else { return nil }
		var counterString = String(counter)
		if 4...6 ~= counterString.count {
			counterString = String(counterString.dropLast(3)) + "K"
		} else if counterString.count > 6 {
			counterString = String(counterString.dropLast(6)) + "M"
		}
		return counterString
		
	}
	
	private func selectProfile(for sourcseId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresenatable {
		let profilesOrGroups: [ProfileRepresenatable] = sourcseId >= 0 ? profiles : groups
		let normalSourceId = sourcseId >= 0 ? sourcseId : -sourcseId
		return profilesOrGroups.first { $0.id == normalSourceId }!
	}
		
	private func getPhotoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
		guard let attachments = feedItem.attachments else { return [] }
		return attachments.compactMap { (attachment) -> FeedViewModel.FeedCellPhotoAttachment? in
			guard let photo = attachment.photo else { return nil }
			return FeedViewModel.FeedCellPhotoAttachment(photoUrlString: photo.imageBig,
														 widht: photo.width,
														 height: photo.height)
		}
	}

}
