//
//  User.swift
//  NestAwayTask
//
//  Created by Abhinay Varma on 24/04/18.
//  Copyright © 2018 Abhinay Varma. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper
import RealmSwift
import Realm

class User: Object,Mappable  {
	required init?(map: Map) {
		super.init()
	}
	
	@objc dynamic var id:Int = 0
	@objc dynamic var screenName:String = ""
	@objc dynamic var name:String = ""
	@objc dynamic var location:String = ""
	@objc dynamic var desc:String = ""
    var entities:Entity?
	@objc dynamic var profileImageUrl:String = ""
	
	
	func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        location <- map["location"]
        screenName <- map["screenName"]
        desc <- map["description"]
        entities <- map["entities"]
        profileImageUrl <- map["profile_image_url"]
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

class Entity:Object,Mappable {
	required init?(map: Map) {
		super.init()
	}
	
    var url:URLObject?
    var descript: DescriptionObject?
	
	
	func mapping(map:Map) {
		url <- map["url"]
		descript <- map["description"]
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

class DescriptionObject:Object,Mappable {
    var urls:[URLSObject]?

	required init?(map: Map) {
		super.init()
	}
	
	
	func mapping(map: Map) {
		urls <- map["urls"]
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

class URLObject:Object,Mappable {
    required init?(map: Map) {
        super.init()
    }
    
    var urls:[URLSObject]?
	
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
	func mapping(map: Map) {
		urls <- map["urls"]
	}
}

class URLSObject:Object,Mappable {
	@objc dynamic var url:String?
	@objc dynamic var expandedUrl:String?
	@objc dynamic var displayUrl:String?
	@objc dynamic var indices:[Int]?

	
	required init?(map: Map) {
		super.init()
	}
	
	
	func mapping(map: Map) {
		url <- map["url"]
		expandedUrl <- map["expandedUrl"]
		displayUrl <- map["displayUrl"]
		indices <- map["indices"]
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
