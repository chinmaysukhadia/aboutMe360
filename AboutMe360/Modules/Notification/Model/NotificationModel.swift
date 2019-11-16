//
//	RootClass.swift

import Foundation 
import ObjectMapper


class NotificationModel : NSObject, NSCoding, Mappable{

	var message : String?
	var notifiData : [NotifiData]?
	var status : String?


	class func newInstance(map: Map) -> Mappable?{
		return NotificationModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		message <- map["message"]
		notifiData <- map["notifi_data"]
		status <- map["status"]
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         message = aDecoder.decodeObject(forKey: "message") as? String
         notifiData = aDecoder.decodeObject(forKey: "notifi_data") as? [NotifiData]
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
		if notifiData != nil{
			aCoder.encode(notifiData, forKey: "notifi_data")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}

	}

}

// MARK: - Attorney Formatted Data
extension NotificationModel {
    
    class func formattedDataArray(data: [[String : AnyObject]]) -> [NotificationModel]? {
        return Mapper<NotificationModel>().mapArray(JSONArray:data)
    }
    
    class func formattedDataDict(data: [String : AnyObject]) -> NotificationModel? {
        return Mapper<NotificationModel>().map(JSON: data)
    }
}
