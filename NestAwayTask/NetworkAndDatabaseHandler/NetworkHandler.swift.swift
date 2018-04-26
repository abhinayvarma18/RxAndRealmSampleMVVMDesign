import UIKit
import Alamofire
import AlamofireObjectMapper

class NetworkHandler:NSObject {
	
	static let sharedInstance = NetworkHandler()
	var bearerToken:String = ""
	let session = URLSession.shared
	let databaseHandler = DatabaseHandler.sharedManager

	//post request using 2 tokens from constant
	func authenticateAndGetBearerForSearchApi() {
		let apiClientKeyString = KeysAndUrls.consumerKey + ":" + KeysAndUrls.consumerSecret 
		
		if let base64Encoded = apiClientKeyString.getBase64EncodedData()
		{
            let headers:[String:String] = [Constants.authString : base64Encoded,
                   Constants.contentTypeString: Constants.applcationJSONString]

			Alamofire.request(KeysAndUrls.authURL,method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in

				switch(response.result) {
				case .success(_):
					if response.result.value != nil{
						do {
							//let json = try JSONSerialization.jsonObject(with:data, options:[])
							//self.bearerToken = "Bearer " + json["access_token"] as? String ?? ""
							//let json = try JSONSerialization.jsonObject(with:data, options:[])
							let dict:[String:String] = response.result.value as? [String:String] ?? [:]
							self.bearerToken = Constants.bearerString + dict["access_token"]!
						}
					}
					break

				case .failure(_):
					print("Failure : \(response.result.error)")
					break

				}
			}

			
//            Alamofire.request(url, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: {(response:DataResponse) in
//                if let response = response as? Dictionary<String,Any> {
//                    do {
//                        //let json = try JSONSerialization.jsonObject(with:data, options:[])
//                        //self.bearerToken = "Bearer " + json["access_token"] as? String ?? ""
//                        //let json = try JSONSerialization.jsonObject(with:data, options:[])
//                        self.bearerToken = Constants.bearerString + response["access_token"] as? String ?? ""
//                    }
//                }
//            })
		}
	}



	//searchApi use bearer token as property
    func searchTweets(_ key:String,_ completion:@escaping ((Tweets?)->())) {
		let headers = [Constants.authString : self.bearerToken,
                   Constants.contentTypeString: Constants.applcationJSONString]

		let URL = KeysAndUrls.searchURL + key
		
		// TweetGateway.searchTweet(key,...)
        Alamofire.request(URL).responseObject { (response: DataResponse<Tweets>) in
            if let tweets = response.result.value, tweets.tweets.count > 0 {
                self.databaseHandler.insertTweetsAndSearchQueryInDatabase(key, tweetObject:tweets)
                completion(tweets)
            }else if(false) {
                //if no search data is found
                completion(nil)
            } else {
                //no internet or time out find if key is available in local db and fetch result
                self.databaseHandler.findValuesInDatabaseForSearchKey(searchString:key)
            }
        }
	}
}
