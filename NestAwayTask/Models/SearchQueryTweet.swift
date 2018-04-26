import UIKit
import Realm
import RealmSwift
import ObjectMapper

class SearchQueryTweet:Object,Mappable {
    @objc dynamic var tweetSearchkey:String?
    @objc dynamic var tweetIds:[String]?
    @objc dynamic var timeStamp = NSDate()

	func mapping(map:Map) {
		tweetSearchkey <- map["tweetSearchKey"]
		tweetIds <- map["tweetIds"]
	}


	required init?(map: Map) {
		super.init()
		tweetSearchkey <- map["tweetSearchKey"]
		tweetIds <- map["tweetIds"]
	}
	
	required init() {
		fatalError("init() has not been implemented")
	}
	
	required init(value: Any, schema: RLMSchema) {
		fatalError("init(value:schema:) has not been implemented")
	}
	
	required init(realm: RLMRealm, schema: RLMObjectSchema) {
		fatalError("init(realm:schema:) has not been implemented")
	}
	
}
