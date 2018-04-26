import UIKit
import Realm
import RxSwift

struct MainViewControllerViewModel {
	var tweetsFromNetworkCall:Tweets?
	var tweets: Observable<Tweets?>?
	var searchString: Variable<String>?

	var isValid: Observable<Bool> {
		return Observable(searchString!.asObservable()) { text -> Bool in
			if text?.count > 2 {
				return true
			}
			return false
		}
	}

	mutating func updateData() {
		tweets = Observable.just(tweetsFromNetworkCall)
	}
}
