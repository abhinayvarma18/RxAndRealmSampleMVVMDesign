//
//  ViewController.swift
//  NestAwayTask
//
//  Created by Sreenath Bagineni on 24/04/18.
//  Copyright © 2018 Sreenath Bagineni. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
	let networkHandler = NetworkHandler.sharedInstance
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchField:UITextField!
	@IBOutlet weak var searchButton:UIButton!

	var viewModel = MainViewControllerViewModel(tweetsFromNetworkCall: nil, tweets: nil, searchString: nil)
	var disposeBag = DisposeBag()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		bindData()
		self.updateTableViewBinding()
	}

	private func updateTableViewBinding() {
		tableView.rx.modelSelected(Tweet.self).subscribe(onNext: {
			tweet in
			print(tweet.tweetId)
		}).disposed(by: disposeBag)
		
		tableView.rx.itemSelected.subscribe(onNext : {
			[weak self] indexPath in
			if let cell = self?.tableView.cellForRow(at: indexPath) as? TableViewCell {
				cell.updateValues()
			}//or shift all the logic to cell's function
		}).disposed(by: disposeBag)
	}


	//MARK:binding of ui elements
	private func bindData() {
		viewModel.updateData()
		tableView.dataSource = nil
	
		
//		viewModel.tweets?.bind(to: tableView.rx.items(cellIdentifier: "cell"))
//
//		viewModel.tweets.bind(to: tableView.rx.items(cellIdentifier: "cell")) { (row, tweet, cell) in
//			if let cellToUse = cell as? TableViewCell {
//				cellToUse.tweet = tweet
//			}
//		}.addDisposableTo(disposeBag)
		
		viewModel.tweets
			.bind(to: tableView.rx.items(cellIdentifier: "cell",
										 cellType: UITableViewCell.self)) {  row, element, cell in
					if let cellToUse = cell as? TableViewCell {
						cellToUse.tweet = tweet
					}
			}
			.addDisposableTo(disposeBag)
		bindDataForSearchTextFieldAndButton()
	}

	func bindDataForSearchTextFieldAndButton() {
		_ = searchField.rx.text.map {$0 ?? ""}.bind(to: viewModel.searchString!)
		_ = viewModel.isValid.bind(to: searchButton.rx.isEnabled)

		viewModel.isValid.subscribe({[weak self] isValidTrue in
			self?.searchButton.backgroundColor = isValidTrue.element! ? UIColor.green : UIColor.lightGray
		}).disposed(by: disposeBag)
	}

	//MARK:Action on search
	func searchTweet(_ sender:UIButton) {
		networkHandler.searchTweets(searchField.text!,{[weak self](tweets) in
			self?.viewModel.tweetsFromNetworkCall = tweets
			self?.bindData()
		})
	}
}

