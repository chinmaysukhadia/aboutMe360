//
//	NotifiData.swift

import Foundation 
import ObjectMapper


class NotifiData :  Mappable{

	var deviceToken : String?
	var id : String?
	var isAcceptable : Bool?
	var name : String?
	var pimg : String?
	var ratedBy : String?
	var ratedTo : String?
	var ratingId : String?
	var status : String?

//	class func newInstance(map: Map) -> Mappable?{
//		return NotifiData()
//	}
	required init?(map: Map){}
	//private override init(){}

	func mapping(map: Map)
	{
		deviceToken <- map["device_token"]
		id <- map["id"]
		isAcceptable <- map["is_acceptable"]
		name <- map["name"]
		pimg <- map["pimg"]
		ratedBy <- map["rated_by"]
		ratedTo <- map["rated_to"]
		ratingId <- map["rating_id"]
		status <- map["status"]
        
        if isAcceptable == nil {
            var acceptable = ""
            acceptable <- map["is_acceptable"]
            isAcceptable = Utilities.toBool(acceptable)
        }
	}

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required init(coder aDecoder: NSCoder)
//	{
//         deviceToken = aDecoder.decodeObject(forKey: "device_token") as? String
//         id = aDecoder.decodeObject(forKey: "id") as? String
//         isAcceptable = aDecoder.decodeObject(forKey: "is_acceptable") as? Bool
//         name = aDecoder.decodeObject(forKey: "name") as? String
//         pimg = aDecoder.decodeObject(forKey: "pimg") as? String
//         ratedBy = aDecoder.decodeObject(forKey: "rated_by") as? String
//         ratedTo = aDecoder.decodeObject(forKey: "rated_to") as? String
//         ratingId = aDecoder.decodeObject(forKey: "rating_id") as? String
//         status = aDecoder.decodeObject(forKey: "status") as? String
//
//	}
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc func encode(with aCoder: NSCoder)
//	{
//		if deviceToken != nil{
//			aCoder.encode(deviceToken, forKey: "device_token")
//		}
//		if id != nil{
//			aCoder.encode(id, forKey: "id")
//		}
//		if isAcceptable != nil{
//			aCoder.encode(isAcceptable, forKey: "is_acceptable")
//		}
//		if name != nil{
//			aCoder.encode(name, forKey: "name")
//		}
//		if pimg != nil{
//			aCoder.encode(pimg, forKey: "pimg")
//		}
//		if ratedBy != nil{
//			aCoder.encode(ratedBy, forKey: "rated_by")
//		}
//		if ratedTo != nil{
//			aCoder.encode(ratedTo, forKey: "rated_to")
//		}
//		if ratingId != nil{
//			aCoder.encode(ratingId, forKey: "rating_id")
//		}
//		if status != nil{
//			aCoder.encode(status, forKey: "status")
//		}
//
//	}

}
