//
//	RootClass.swift

import Foundation 
import ObjectMapper


class HomeModel : NSObject, NSCoding, Mappable{

	var homeData : HomeData?
	var message : String?
	var pimgBaseUrl : String?
	var status : String?


	class func newInstance(map: Map) -> Mappable?{
		return HomeModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		homeData <- map["data"]
		message <- map["message"]
		pimgBaseUrl <- map["pimg_base_url"]
		status <- map["status"]
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         homeData = aDecoder.decodeObject(forKey: "data") as? HomeData
         message = aDecoder.decodeObject(forKey: "message") as? String
         pimgBaseUrl = aDecoder.decodeObject(forKey: "pimg_base_url") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if homeData != nil{
			aCoder.encode(homeData, forKey: "data")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if pimgBaseUrl != nil{
			aCoder.encode(pimgBaseUrl, forKey: "pimg_base_url")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}

	}

}



// MARK: - Attorney Formatted Data
extension HomeModel {
    
    class func formattedDataArray(data: [[String : AnyObject]]) -> [HomeModel]? {
        return Mapper<HomeModel>().mapArray(JSONArray:data)
    }
    
    class func formattedDataDict(data: [String : AnyObject]) -> HomeModel? {
        return Mapper<HomeModel>().map(JSON: data)
    }
}
