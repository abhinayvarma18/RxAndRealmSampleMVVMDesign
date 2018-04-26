
import UIKit

struct KeysAndUrls {
   static let consumerKey:String = "Wau2JpjqydnYVZKN2Oh4UbRD7"
   static let consumerSecret:String = "NN19rUTPs4yJbWktNcBl6dnBdmaoQj4mxYhfy72X6WthRZno2A"
   static let authURL:String = "https://api.twitter.com/oauth2/token?grant_type=client_credentials"
   static let searchURL:String = "https://api.twitter.com/1.1/search/tweets.json?q="
}

struct Constants {
	static let postString:String = "POST"
	static let authString:String = "Authorization"
	static let contentTypeString:String = "Content-Type"
	static let applcationJSONString:String = "application/json"
	static let accessTokenString:String = "access_token"
	static let bearerString:String = "Bearer "
	
	static let tweetSearchKey = "tweetSearchKey"
	static let tweetIds = "tweetIds"

    static let totalSearchQueryValidationValue:Int = 10



}

struct ModelKeys {

}
