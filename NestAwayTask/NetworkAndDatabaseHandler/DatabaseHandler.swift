import UIKit
import Realm
import RealmSwift
import ObjectMapper

class DatabaseHandler:Any {
	static let sharedManager = DatabaseHandler()

	fileprivate(set) var defaultRealm: Realm!
    fileprivate var config = Realm.Configuration()

	fileprivate init() {
		 do {
            defaultRealm = try Realm(configuration: config)
        } catch {
            let nserror = error as NSError
           // Crashlytics.sharedInstance().recordError(nserror)
           print(nserror)
        }
	}

	
	func eraseAll() {
        do {
            let realm = try createRealm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            let nserror = error as NSError
			print(nserror)
        }
    }

    func createRealm() throws -> Realm {
        return try Realm(configuration: config)
    }
	
	//MARK:Insertion/Deletion Code Tweets + User + SearchQuery Saving
	
	//MARK: Save Tweets
    func saveTweets(_ tweets:Tweets) {
		for tweet in tweets.tweets {
			self.saveUser(tweet.user)
			self.saveTweet(tweet)
        }
    }
	func saveTweet(_ tweet:Tweet?) {
        let realm = try! Realm()
		if realm.objects(Tweet.self).first != nil {
			return
		}
		do {
			try tweet?.save(true)
		}catch {
			
		}
	}
    //MARK: Save User
    func saveUser(_ user:User?) {
		if self.defaultRealm?.objects(User.self).filter("id == %@",user?.id ?? 0).first != nil {
            return
       }
	   do {
		  try user?.save(true)
		}catch {
		
		}
		
    }

    //MARK: Save Search Query
	func addSearchQueryInDB(_ key:String, _ tweetObject:Tweets?) {
        let jsonForSearchQuery = [Constants.tweetSearchKey: key, Constants.tweetIds : tweetObject?.tweets.map({ (tweet) -> String in
            return String(tweet.tweetId)
		})] as [String : Any]

        let searchQueryObject = SearchQueryTweet(map: Map(mappingType: .toJSON, JSON: jsonForSearchQuery))
		do {
			try searchQueryObject?.save(true)
		}catch{
			
		}
    }

    //MARK: Delete Tweets when overflowed
    func deleteOldestSearchRequest() {
        let objectToDelete = self.defaultRealm?.objects(SearchQueryTweet.self).filter("timeStamp < 0").first
		self.defaultRealm?.delete(objectToDelete!)
    }


    //MARK: inserts a search query in realm with value as tweetIds
	func insertTweetsAndSearchQueryInDatabase(_ key:String?, tweetObject:Tweets?) {
		//check if total value\
		if (self.findTotalCountOfSearchQueriesStored() > Constants.totalSearchQueryValidationValue) {
            //delete if limit exceeds to number of storage allowed in DB
	        self.deleteOldestSearchRequest()
		} 
        self.saveTweets(tweetObject!)
        self.addSearchQueryInDB(key!,tweetObject)
	}



    //MARK:Fetch and Helper Methods

    //MARK:returns a searchKeyTweetsFromDB
	func findValuesInDatabaseForSearchKey(searchString:String) -> [Tweet]? {
		let object = self.defaultRealm?.objects(Tweets.self).filter("id == %@",searchString).first
        
        for tweet in object?.tweets ?? [] {
            let userObjects = self.defaultRealm?.objects(User.self).filter("userId == %@",tweet.userId)
			tweet.user = userObjects?.first
        }

        return object?.tweets
	}


    //MARK:returns number of tweet searches stored
	func findTotalCountOfSearchQueriesStored() -> Int {
		return self.defaultRealm?.objects(SearchQueryTweet.self).count ?? 0
	}

}

extension Object {

//    fileprivate func realmInst() -> Realm {
//        return self.realm
//    }

    /** Must be called from main thread */
    func save(_ update: Bool = true) throws {
        let realm = try Realm()
        try realm.write() {
			realm.add(self, update: update)
        }
    }

    /** Must be called from main thread */
    static func save(_ objects: [Object], update: Bool = true) throws {
		guard objects.first != nil else {
            return
        }
        let realm = try Realm()
        try realm.write() {
            objects.forEach() { realm.add($0, update: update) }
        }
    }
    
}
