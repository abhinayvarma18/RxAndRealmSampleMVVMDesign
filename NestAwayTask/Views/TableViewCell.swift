//
//  TableViewCell.swift
//  TableRx
//
//  Created by Abhinay Varma
//  Copyright © 2018 Abhinay Varma. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

	@IBOutlet weak var label1: UILabel!
	@IBOutlet weak var label2: UILabel!
	
	var tweet: Tweet?
	
	private func updateUI(){
		self.label1.text = tweet?.tweetId
		self.label2.text = tweet?.tweetText
	}

	func updateValues () {
		self.label1.text = tweet?.tweetId ?? ""
		self.label2.text = tweet?.tweetText ?? ""
	}
	
}
