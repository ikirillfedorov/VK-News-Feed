//
//  NewsFeedCodeCell.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 02.02.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

protocol NewsFeedCodeCellDelegate: class {
	func revelPost(for cell: NewsFeedCodeCell)
}

final class NewsFeedCodeCell: UITableViewCell {
	
	static let reuseId = "NewsFeedCodeCell"
	weak var delegate: NewsFeedCodeCellDelegate?
	
	// first layer
	let cardView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 10
		view.clipsToBounds = true
		return view
	}()
	// second layer
	let topView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let postLabel: UITextView = {
		let textView = UITextView()
		textView.font = Constants.postLabelFont
		textView.isScrollEnabled = false
		textView.isSelectable = true
		textView.isUserInteractionEnabled = true
		textView.isEditable = false
		textView.dataDetectorTypes = UIDataDetectorTypes.all
		let padding = textView.textContainer.lineFragmentPadding
		textView.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
		textView.textColor = .black
		return textView
	}()
	
	let galleryCollectionView = GalleryCollectionView()
	
	let postImageView: WebImageView = {
		let imageView = WebImageView()
		imageView.backgroundColor = UIColor(red: 227 / 255, green: 229 / 255, blue: 232 / 255, alpha: 1)
		return imageView
	}()
	
	let moreTextButton: UIButton = {
		let button = UIButton()
		button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
		button.setTitleColor(Colors.showMoreTextButtonTitle, for: .normal)
		button.contentHorizontalAlignment = .left
		button.contentVerticalAlignment = .center
		button.setTitle("Показать полностью...", for: .normal)
		return button
	}()
	
	let bottomView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	// third layer on top view
	let iconImageView: WebImageView = {
		let imageView = WebImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	let nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
		label.numberOfLines = 0
		label.textColor = .black
		return label
	}()
	
	let dateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.detailText
		label.font = UIFont.systemFont(ofSize: 12)
		return label
	}()
	
	// third layer on bottom view
	let likesView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let commentsView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	let sharesView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	let viewsView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	// fourth layer
	let likesImage: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = #imageLiteral(resourceName: "like")
		return imageView
	}()
	
	let commentsImage: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = #imageLiteral(resourceName: "comment")
		return imageView
	}()
	
	let sharesImage: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = #imageLiteral(resourceName: "share")
		return imageView
	}()
	
	let viewsImage: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = #imageLiteral(resourceName: "eye")
		return imageView
	}()
	
	let likesLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.detailText
		label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
		label.lineBreakMode = .byClipping
		return label
	}()
	
	let commentsLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.detailText
		label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
		label.lineBreakMode = .byClipping
		return label
	}()
	
	let sharesLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.detailText
		label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
		label.lineBreakMode = .byClipping
		return label
	}()
	
	let viewsLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.detailText
		label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
		label.lineBreakMode = .byClipping
		return label
	}()
	
	override func prepareForReuse() {
		iconImageView.setImage(fromUrl: nil)
		postImageView.setImage(fromUrl: nil)
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.backgroundColor = .clear
		self.selectionStyle = .none
		moreTextButton.addTarget(self, action: #selector(moreTextButtonPressed), for: .touchUpInside)
		roundIcons()
		makeSubViewsHierarchy()
		setConstraints()
	}
	
	@objc private func moreTextButtonPressed() {
		delegate?.revelPost(for: self)
	}
	
	private func roundIcons() {
		iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
		iconImageView.clipsToBounds = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func set(viewModel: FeedCellViewModel) {
		iconImageView.setImage(fromUrl: viewModel.iconUrlString)
		nameLabel.text = viewModel.name
		dateLabel.text = viewModel.date
		postLabel.text = viewModel.text
		likesLabel.text = viewModel.likes
		commentsLabel.text = viewModel.comments
		sharesLabel.text = viewModel.shares
		viewsLabel.text = viewModel.views
		
		postLabel.frame = viewModel.sizes.postLabelFrame
		bottomView.frame = viewModel.sizes.bottomView
		moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
		
		if let photoAttachments = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
			postImageView.setImage(fromUrl: photoAttachments.photoUrlString)
			postImageView.isHidden = false
			galleryCollectionView.isHidden = true
			postImageView.frame = viewModel.sizes.attachmentFrame
		} else if viewModel.photoAttachments.count > 1 {
			galleryCollectionView.frame = viewModel.sizes.attachmentFrame
			postImageView.isHidden = true
			galleryCollectionView.isHidden = false
			galleryCollectionView.set(photos: viewModel.photoAttachments)
		} else {
			postImageView.isHidden = true
			galleryCollectionView.isHidden = true
		}
	}

	
	private func makeSubViewsHierarchy() {
		// first layer
		self.addSubview(cardView)
		// second layer
		cardView.addSubview(topView)
		cardView.addSubview(postLabel)
		cardView.addSubview(galleryCollectionView)
		cardView.addSubview(postImageView)
		cardView.addSubview(bottomView)
		cardView.addSubview(moreTextButton)
		// third layer on top view
		topView.addSubview(iconImageView)
		topView.addSubview(nameLabel)
		topView.addSubview(dateLabel)
		// third layer on bottom view
		bottomView.addSubview(likesView)
		bottomView.addSubview(commentsView)
		bottomView.addSubview(sharesView)
		bottomView.addSubview(viewsView)
		// fouth layer on bottom view
		likesView.addSubview(likesImage)
		likesView.addSubview(likesLabel)
		
		commentsView.addSubview(commentsImage)
		commentsView.addSubview(commentsLabel)
		
		sharesView.addSubview(sharesImage)
		sharesView.addSubview(sharesLabel)
		
		viewsView.addSubview(viewsImage)
		viewsView.addSubview(viewsLabel)
	}
	
	private func setConstraintForFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
		NSLayoutConstraint.activate([
			imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize),
			imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize),
			
			label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
			label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
	}
	
	private func setConstraints() {
		// first layer
		cardView.fillSuperview(padding: Constants.cardViewInsets)
		
		// second layer
		topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
		topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
		topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
		topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
		
		bottomView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
		bottomView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
		bottomView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8).isActive = true
		bottomView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight - 16).isActive = true

		// third layer on top view
		iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
		iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
		iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
		iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
		
		nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
		nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
		nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
		nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2).isActive = true

		dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
		dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
		dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2).isActive = true
		dateLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 4).isActive = true
		
		// third layer on bottom view
		likesView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
		likesView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
		likesView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
		likesView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsWidth).isActive = true

		commentsView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
		commentsView.leadingAnchor.constraint(equalTo: likesView.trailingAnchor).isActive = true
		commentsView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
		commentsView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsWidth).isActive = true

		sharesView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
		sharesView.leadingAnchor.constraint(equalTo: commentsView.trailingAnchor).isActive = true
		sharesView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
		sharesView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsWidth).isActive = true

		viewsView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
		viewsView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
		viewsView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
		viewsView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsWidth).isActive = true
		
		// fourth layer on bottom view
		setConstraintForFourthLayer(view: likesView, imageView: likesImage, label: likesLabel)
		setConstraintForFourthLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
		setConstraintForFourthLayer(view: sharesView, imageView: sharesImage, label: sharesLabel)
		setConstraintForFourthLayer(view: viewsView, imageView: viewsImage, label: viewsLabel)
	}
}
