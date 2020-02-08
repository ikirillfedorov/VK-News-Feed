//
//  InsetableTextField.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 05.02.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

final class InsetableTextField: UITextField {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = Colors.titleView
		placeholder = "Search..."
		font = UIFont.systemFont(ofSize: 14)
		clearButtonMode = .whileEditing
		borderStyle = .none
		layer.cornerRadius = 10
		layer.masksToBounds = true
		leftView = UIImageView(image: #imageLiteral(resourceName: "search"))
		leftView?.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
		leftViewMode = .always
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
		var rect = super.leftViewRect(forBounds: bounds)
		rect.origin.x += 12
		return rect
	}
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: 36, dy: 0)
	}
	
	override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: 36, dy: 0)
	}
}
