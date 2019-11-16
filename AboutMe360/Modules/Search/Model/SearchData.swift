//
//	SearchData.swift

import Foundation 
import ObjectMapper


class SearchData : NSObject, NSCoding, Mappable{

	var designation : String?
	var id : String?
	var name : String?
	var profileImg : String?
	var rating : String?

	class func newInstance(map: Map) -> Mappable?{
		return SearchData()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		designation <- map["designation"]
		id <- map["id"]
		name <- map["name"]
		profileImg <- map["profile_img"]
		rating <- map["rating"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         designation = aDecoder.decodeObject(forKey: "designation") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         profileImg = aDecoder.decodeObject(forKey: "profile_img") as? String
         rating = aDecoder.decodeObject(forKey: "rating") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if designation != nil{
			aCoder.encode(designation, forKey: "designation")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if profileImg != nil{
			aCoder.encode(profileImg, forKey: "profile_img")
		}
		if rating != nil{
			aCoder.encode(rating, forKey: "rating")
		}

	}

}
