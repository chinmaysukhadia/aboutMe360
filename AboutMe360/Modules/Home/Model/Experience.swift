//
//	Experience.swift

import Foundation 
import ObjectMapper

class Experience : NSObject, NSCoding, Mappable{

	var currentlyWorking : String?
	var designation : String?
	var duration : String?
	var id : String?
	var industry : String?
	var jobProfile : String?
	var orgName : String?
	var status : String?
	var userId : String?
	var workLocation : String?

	class func newInstance(map: Map) -> Mappable?{
		return Experience()
	}
    
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		currentlyWorking <- map["currently_working"]
		designation <- map["designation"]
		duration <- map["duration"]
		id <- map["id"]
		industry <- map["industry"]
		jobProfile <- map["job_profile"]
		orgName <- map["org_name"]
		status <- map["status"]
		userId <- map["user_id"]
		workLocation <- map["work_location"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         currentlyWorking = aDecoder.decodeObject(forKey: "currently_working") as? String
         designation = aDecoder.decodeObject(forKey: "designation") as? String
         duration = aDecoder.decodeObject(forKey: "duration") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         industry = aDecoder.decodeObject(forKey: "industry") as? String
         jobProfile = aDecoder.decodeObject(forKey: "job_profile") as? String
         orgName = aDecoder.decodeObject(forKey: "org_name") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? String
         workLocation = aDecoder.decodeObject(forKey: "work_location") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if currentlyWorking != nil{
			aCoder.encode(currentlyWorking, forKey: "currently_working")
		}
		if designation != nil{
			aCoder.encode(designation, forKey: "designation")
		}
		if duration != nil{
			aCoder.encode(duration, forKey: "duration")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if industry != nil{
			aCoder.encode(industry, forKey: "industry")
		}
		if jobProfile != nil{
			aCoder.encode(jobProfile, forKey: "job_profile")
		}
		if orgName != nil{
			aCoder.encode(orgName, forKey: "org_name")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}
		if workLocation != nil{
			aCoder.encode(workLocation, forKey: "work_location")
		}

	}

}
