//
//	RootClass.swift

import Foundation 
import ObjectMapper


class SearchModel : NSObject, NSCoding, Mappable{

	var message : String?
	var searchData : [SearchData]?
	var status : String?


	class func newInstance(map: Map) -> Mappable?{
		return SearchModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		message <- map["message"]
		searchData <- map["search_data"]
		status <- map["status"]
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         message = aDecoder.decodeObject(forKey: "message") as? String
         searchData = aDecoder.decodeObject(forKey: "search_data") as? [SearchData]
         status = aDecoder.decodeObject(forKey: "status") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if searchData != nil{
			aCoder.encode(searchData, forKey: "search_data")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}

	}

}

// MARK: - Attorney Formatted Data
extension SearchModel {
    
    class func formattedDataArray(data: [[String : AnyObject]]) -> [SearchModel]? {
        return Mapper<SearchModel>().mapArray(JSONArray:data)
    }
    
    class func formattedDataDict(data: [String : AnyObject]) -> SearchModel? {
        return Mapper<SearchModel>().map(JSON: data)
    }
}
