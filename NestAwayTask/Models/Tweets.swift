//
//  Tweet.swift
//  NestAwayTask
//
//  Created by Abhinay Varm on 24/04/18.
//  Copyright © 2018 Sreenath Bagineni. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import Realm
import RealmSwift
import ObjectMapper

class Tweets: Object,Mappable {
    var tweets:[Tweet] = []
	// List<Dog>()
	func mapping(map: Map) {
		tweets <- map["statuses"]
	}
	
	
	required init?(map: Map) {
		super.init()
    }
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
	
	required init() {
		fatalError("init() has not been implemented")
	}
	
	
}


class Tweet: Object, Mappable {
	@objc dynamic var createdAt:String = ""
	@objc dynamic var tweetId:String = ""
	@objc dynamic var tweetText:String = ""
	var user:User?
	@objc dynamic var userId:String = ""
	@objc dynamic var geo:String = ""
	@objc dynamic var coordinate:String = ""
	@objc dynamic var retweetCount:Int = 0
	@objc dynamic var favouriteCount:Int = 0
    var entities:TweetEntity?

	func mapping(map:Map) {
		createdAt <- map["created_at"]
		tweetId <- map["id"]
		tweetText <- map["text"]
		user <- map["user"]
		userId <- map["user"]["id"]
		geo <- map["geo"]
		coordinate <- map["coordinates"]
		retweetCount <- map["retweet_count"]
		favouriteCount <- map["favorite_count"]
		entities <- map["entities"]
	}
	
	required init?(map: Map) {
		super.init()
	}
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
}


class TweetEntity:Object,Mappable {
	@objc dynamic var hashTags:[String] = []
	@objc dynamic var symbols:[String] = []
	@objc dynamic var userMentions:[String] = []
    var urls:URLObject?

	func mapping(map:Map) {
		hashTags <- map["hashtags"]
		symbols <- map["symbols"]
		userMentions <- map["user_mentions"]
		urls <- map["urls"]
	}
	
	required init?(map: Map) {
		super.init()
	}

    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
}
