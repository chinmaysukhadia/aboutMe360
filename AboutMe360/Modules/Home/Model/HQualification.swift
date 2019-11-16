//
//	HQualification.swift

import Foundation 
import ObjectMapper


class HQualification : NSObject, NSCoding, Mappable{

	var id : String?
	var qualification : String?
	var status : String?
	var userId : String?


	class func newInstance(map: Map) -> Mappable?{
		return HQualification()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["id"]
		qualification <- map["qualification"]
		status <- map["status"]
		userId <- map["user_id"]
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "id") as? String
         qualification = aDecoder.decodeObject(forKey: "qualification") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if qualification != nil{
			aCoder.encode(qualification, forKey: "qualification")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}

	}

}
